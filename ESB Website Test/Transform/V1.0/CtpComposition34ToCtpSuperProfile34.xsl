<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                       xmlns:xs="http://www.w3.org/2001/XMLSchema"        
                       version="2.0">
                       
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="commandToPublishVersion" select="'V3.4'"/>	
	<xsl:param name="superProfileVersion" select="'V1.4'"/>	
	<xsl:param name="noContentFoundString" select="'No content found for: '"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="commandToPublish">
		<!--+
			 | Copy the root element and its attributes and continue
            +-->
		<xsl:element name="{local-name()}">
			<xsl:copy-of select="@source"/>
			<xsl:attribute name="version">
				<xsl:value-of select="$commandToPublishVersion" />
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<!--+
         | Replace the composition element with the superProfile element and set the appropiate version
		 +-->
	<xsl:template match="composition">
		<xsl:element name="superProfile">
			<xsl:attribute name="version">
				<xsl:value-of select="$superProfileVersion"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<!--+
         | Build structure according to the superProfile.xsd
         +--> 
	<xsl:template match="installBase">
		<xsl:apply-templates select="externId" mode="selectNode" />
		<xsl:apply-templates select="status" mode="selectNode" />	
		<xsl:apply-templates select="account" mode="selectTree" />
		<xsl:apply-templates select="order/main/product" mode="selectTree"/>	
		<xsl:apply-templates select="placement/heading" mode="selectTree" />
		<xsl:if test="count(placement/targetArea) &gt; 0">
				<xsl:apply-templates select="placement/targetArea[1]" mode="selectTree" />
		</xsl:if>

		<xsl:element name="outlet">
			<xsl:apply-templates select="../outlet/outletId" mode="selectNode" />
			<!--+
				 | Order the content of the installbase not based on linesequence, but on
				 | name, address, telecom, web, email, visual
				 +-->
			<xsl:apply-templates select="line/content/outlet[element/text() = 'name']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'address']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'telecom']" mode="contentSelect">
				<xsl:with-param name="lineType" select="line/lineType"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="line/content/outlet[element/text() = 'web']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'email']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'visual']" mode="contentSelect" />
		</xsl:element>
		
	</xsl:template>
		
	<xsl:template match="outlet" mode="contentSelect">
		<xsl:param name="lineType"/>
		<xsl:variable name="aidRef" select="aid"/>
		<xsl:apply-templates select="../../../../outlet/node()[@aid = $aidRef]"  mode="selectTree">
			<xsl:with-param name="lineType" select="$lineType"/>
		</xsl:apply-templates>	
	</xsl:template>
	
	<xsl:template match="*" mode="selectValue">		
			<xsl:value-of select="."/>
	</xsl:template>		
		
	<xsl:template match="*" mode="selectNode">
		<xsl:element name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	
	<!--+
		| Temporary fix: see issue DTGESB-2675
		| Reason of this fix is that outlets did not pass full validation and therefore
		| miss context and derived types. When this is fixed, this template match can
		| be removed.
		+-->
	<xsl:template match="telecom" mode="selectTree">
		<xsl:param name="lineType"/>
		<!--
			<telecom aid="5244022c000e020012000014">
                <countryCode/>
                <areaCode>021</areaCode>
                <connectionNumber>6389454</connectionNumber>
                <nameNumber/>
                <extensionNumber/>
                <rate/>
                <full/>
                
                <context/>
                <derived/>
                
                <quality/>
            </telecom>
		-->
		<xsl:variable name="totalContextTypes">
			<xsl:value-of select="count(context)"/>
		</xsl:variable>
		<xsl:variable name="totalDerivedTypes">
			<xsl:value-of select="count(derived)"/>
		</xsl:variable>
		<xsl:choose>
			<!-- When context or derived types are missing, add these -->
			<xsl:when test="$totalContextTypes = 0 or $totalDerivedTypes = 0">
				<xsl:element name="telecom">
					<xsl:copy-of select="@*"/>
					<!--
					<xsl:comment>
						<xsl:value-of select="concat('Total context types: ', $totalContextTypes)"/>
					</xsl:comment>
					<xsl:comment>
						<xsl:value-of select="concat('Total derived types: ', $totalDerivedTypes)"/>
					</xsl:comment>
					-->
					<xsl:apply-templates mode="dirtyHack">
						<xsl:with-param name="lineType" select="$lineType"/>
						<xsl:with-param name="totalContextTypes" select="$totalContextTypes"/>
						<xsl:with-param name="totalDerivedTypes" select="$totalDerivedTypes"/>
					</xsl:apply-templates>
				</xsl:element>
			</xsl:when>
			<!-- In case there is a context and a derived type, all is oke and simply copy the telecom element -->
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<!--+
		| Associated with temporary fix: see issue DTGESB-2675
		+-->
	<xsl:template match="*" mode="dirtyHack">
		<xsl:param name="lineType"/>
		<xsl:param name="totalContextTypes"/>
		<xsl:param name="totalDerivedTypes"/>
		<xsl:choose>
			<xsl:when test="local-name() = 'full'">
				<xsl:copy-of select="." />
				<!--
					Tijdelijke functionalteit omdat de telecom context types (phone/fax) nog niet beschikbaar zijn in CRM en MIG in de november release (fix voor DTGCONTST-337)
					indien outlet/telecom al wel een context/type heeft:

    				geen context type toevoegen

					Indien outlet/telecom nog geen context/type heeft en indien upper(installBase/line/lineType) wel FAX bevat
					(bijvoorbeeld <lineType>ONLINEFax_incl</lineType> )

   					toevoegen <context><type>fax</type></context>

					Indien outlet/telecom nog geen context/type heeft en indien upper(installBase/line/lineType) niet FAX bevat

    				toevoegen <context><type>phone</type></context>
				-->
				<xsl:if test="$totalContextTypes = 0">
					<xsl:element name="context">
						<xsl:element name="type">
							<xsl:choose>
								<!-- ONLINEFax_incl -->
								<xsl:when test="contains($lineType, 'Fax')">
									<xsl:text>fax</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>phone</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:if test="$totalContextTypes &gt; 0">
					<!--
					<xsl:comment>Must copy context here</xsl:comment>
					-->
					<xsl:apply-templates select="../context" mode="selectTree" />
				</xsl:if>
				<!--
					Tijdelijke functionaleit omdat de telefoonnummer validatie nog niet aangeroepen wordt bij de MCD in de november release (fix voor DTGCONTST-337)
					Indien outlet/telecom al wel een derived/type heeft:

    				geen derived type toevoegen

					Indien outlet/telecom nog geen derived/type heeft en areacode gelijk is aan "06"

    				toevoegen <derived><type>mobile</type></derived>

					Indien outlet/telecom nog geen derived/type heeft en areacode ongelijk is aan "06"

    				toevoegen <derived><type>regional</type></derived>
				-->
				<xsl:if test="$totalDerivedTypes = 0">
					<xsl:element name="derived">
						<xsl:element name="type">
							<xsl:choose>
								<!-- ONLINEMob_incl -->
								<xsl:when test="contains($lineType, 'Mob')">
									<xsl:text>mobile</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>regional</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:if test="$totalDerivedTypes &gt; 0">
					<!--
					<xsl:comment>Must copy derived here</xsl:comment>
					-->
					<xsl:apply-templates select="../derived" mode="selectTree" />
				</xsl:if>
			</xsl:when>
			<xsl:when test="local-name() = 'context'">
				<!-- Absorb -->
			</xsl:when>
			<xsl:when test="local-name() = 'derived'">
				<!-- Absorb -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="*"  mode="selectTree">
		<xsl:param name="lineType"/>
		<xsl:copy-of select="." />
	</xsl:template>
	
	<!-- Default matcher -->
	<xsl:template match="*"/>
	
</xsl:stylesheet>
