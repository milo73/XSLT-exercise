<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                       xmlns:xs="http://www.w3.org/2001/XMLSchema"   
                        xmlns:functx="http://www.functx.com"                   
                       version="2.0">
                       
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="seaPublicationVersion" select="'V1.1'"/>
	<xsl:param name="noContentFoundString" select="'No content found for: '"/>
	
	<!--+
	      | This stylesheet transforms a commandToPublish composition message into a commandToPublish seaPublication.		 
		  +-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="commandToFulfill">
		<!--+
			 | Copy the root element and its attributes and continue
            +-->
		<xsl:element name="{local-name()}">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<!--+
         | Replace the composition element with the seaPublication element and set the appropiate version
		 +-->
	<xsl:template match="composition">
		<xsl:element name="seaPublication">
			<xsl:attribute name="version"><xsl:value-of select="$seaPublicationVersion"/></xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<!--+
         | Build structure according to the seaPublication.xsd
         +--> 
	<xsl:template match="installBase">
		<xsl:apply-templates select="externId" />
		<xsl:apply-templates select="account" mode="selectTree" />
		<xsl:apply-templates select="order/main/product" mode="selectTree"/>	
		
		<xsl:element name="budget">
			<xsl:element name="id">
				<xsl:apply-templates select="guid" mode="selectValue" />
			</xsl:element>
			<xsl:element name="status">
				<xsl:apply-templates select="status" mode="selectValue" />
			</xsl:element>
			<xsl:element name="monthlyBudget">
				<xsl:apply-templates select="order/sea/monthlyBudget" mode="selectValue" />
			</xsl:element>
			<xsl:element name="mediaFraction">
				<xsl:apply-templates select="order/sea/mediaFraction" mode="selectValue" />
			</xsl:element>
			<xsl:element name="requestedStartDate">
				<xsl:apply-templates select="date" mode="selectValue" />
			</xsl:element>			
			<xsl:element name="nrOfMonths">
				<xsl:apply-templates select="period" mode="getMonths" />				
			</xsl:element>			
		</xsl:element>

		<xsl:apply-templates select="placement/heading" mode="selectTree" />

		<xsl:element name="outlet">
			<xsl:apply-templates select="line" mode="line"/>		
		</xsl:element>
		
		<xsl:apply-templates select="instruction" mode="selectTree" />
		
		<xsl:apply-templates select="order" />
		
	</xsl:template>

	<xsl:template match="order" >
		<xsl:element name="legacy">
			<xsl:apply-templates select="salesEmployee" mode="selectTree" />
		</xsl:element>
	</xsl:template>
	<!--+
         | Extract the months part from the period element which is of type xs:duration
         +-->
	<xsl:template match="period" mode="getMonths">	
			<xsl:choose>
				<xsl:when test="matches(.,'P(\d+Y)?.*\d+M.*')">
					 <xsl:value-of select='functx:total-months-from-duration(xs:yearMonthDuration(concat(substring-before(.,"M"),"M")))' />			
				 </xsl:when>
				 <xsl:when test="matches(.,'P\d+Y.*')">					
					<xsl:value-of select='functx:total-months-from-duration(xs:yearMonthDuration(concat(substring-before(.,"Y"),"Y")))' />								
				 </xsl:when>
				<xsl:otherwise>
					 <xsl:comment>
						 <xsl:value-of select="concat('The format specified does not conform to the expected input PnM: ', .)" />
					</xsl:comment>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	<xsl:template match="externId">
		<xsl:element name="merchantId">
			<xsl:apply-templates select="." mode="selectValue"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="line" mode="line">
		<xsl:apply-templates select="content" mode="line" />	
	</xsl:template>
				
	<xsl:template match="content" mode="line">
		<xsl:variable name="aidRef" select="outlet/aid"/>
		<xsl:choose>
			<xsl:when test="../../../outlet/child::*[@aid = $aidRef]">
				<xsl:apply-templates select="../../../outlet/name[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/address[@aid = $aidRef]"  mode="selectTree" />				
				<xsl:apply-templates select="../../../outlet/telecom[@aid = $aidRef]"  mode="selectTree" />					
				<xsl:apply-templates select="../../../outlet/web[@aid = $aidRef]"  mode="selectTree" />			
			</xsl:when>
			<xsl:otherwise>
				<xsl:comment>
						<xsl:value-of select="concat($noContentFoundString, $aidRef)"/>
				</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	
	<xsl:template match="*" mode="selectValue">		
			<xsl:value-of select="."/>
	</xsl:template>		
		
	<xsl:template match="*" mode="selectNode">
		<xsl:element name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="*"  mode="selectTree">
		<xsl:copy-of select="." />
	</xsl:template>
	
	<!-- Default matcher -->
	<xsl:template match="*"/>
	
	<!--+
		 | Function to get the total number of month from a duration.
		| e.g. 
		| P2Y13M  - 2 Years  + 13 months = 37 months
        | P13M   = 13 months
        | P13M3DT10H30M = 13 months
        | P2Y10M3DT10H30M = 34 months
	    | P2Y = 24 months
        +-->
	<xsl:function name="functx:total-months-from-duration" as="xs:decimal?" 
				        xmlns:functx="http://www.functx.com" >
		<xsl:param name="duration" as="xs:yearMonthDuration?"/> 
	    <xsl:sequence select="$duration div xs:yearMonthDuration('P1M')"/>   
	</xsl:function>	
	
</xsl:stylesheet>
