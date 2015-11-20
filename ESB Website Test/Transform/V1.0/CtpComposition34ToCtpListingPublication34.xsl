<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:output omit-xml-declaration="yes"/>
	
	<xsl:param name="listingPublicationVersion" select="'V1.2'"/>
	<xsl:param name="ctpVersion" select="'V3.4'"/>
	<xsl:param name="noContentFoundString" select="'No content found for: '"/>
	
	<!--+
	    | This stylesheet transforms a commandToPublish composition message into a commandToPublish listingPublication.
	    | Changes in listingPublication 1.2 vs 1.1:
	    | - inheritance of new outlet version
	    | Changes in listingPublication 1.1 vs 1.0:
	    | - added social as lineType and placed it in correct order
		+-->

	<xsl:template match="/">		
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="commandToPublish">
		<!--+
			| Copy the root element, update the attributes and continue
            +-->
		<xsl:element name="{local-name()}">
			<xsl:attribute name="version">
				<xsl:value-of select="$ctpVersion"/>
			</xsl:attribute>
			<xsl:attribute name="source">
				<xsl:value-of select="@source"/>
			</xsl:attribute>
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="composition">
		<xsl:element name="listingPublication">
			<xsl:attribute name="version">
				<xsl:value-of select="$listingPublicationVersion"/>
			</xsl:attribute>
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>
		
	<xsl:template match="installBase">
			<xsl:apply-templates select="externId" mode="selectNode"/>
			<xsl:apply-templates select="status" mode="selectNode"/>
			<xsl:apply-templates select="account"  mode="selectTree" />			
			<xsl:apply-templates select="order/main" mode="main"/>		
			<xsl:apply-templates select="order/option" mode="option"/>	
				 
			<xsl:if test="order/listing/ranking">			 
				<xsl:apply-templates select="order/listing/ranking"  mode="selectTree" />	
			</xsl:if>
			 
			<xsl:if test="placement/heading">
				<xsl:apply-templates select="placement/heading"  mode="selectTree" />	
			</xsl:if>	

			<xsl:apply-templates select="placement/targetArea"  mode="selectTree" />	

			<xsl:if test="order/listing/edition">
				<xsl:apply-templates select="order/listing/edition"  mode="selectTree" />	
			</xsl:if>
			
			<xsl:apply-templates select="line" mode="line">
				<xsl:sort select="@sequence" order="ascending" data-type="number"/>
			</xsl:apply-templates>
			
	</xsl:template>
	
	<xsl:template match="*"  mode="selectNode">
		 <xsl:element name="{local-name()}">
            <xsl:value-of select="." />
        </xsl:element>
	</xsl:template>

	<xsl:template match="*"  mode="selectTree">
            <xsl:copy-of select="." />
	</xsl:template>
	
	<xsl:template match="main" mode="main">
		<xsl:element name="mainProduct">
			<xsl:apply-templates mode="main"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="product" mode="main">
		<xsl:apply-templates select="code" mode="selectNode" />
		<xsl:apply-templates select="displayName" mode="selectNode" />
	</xsl:template>
	
	<xsl:template match="option" mode="option">
		<xsl:element name="optionProduct">
			<xsl:apply-templates mode="option"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="product" mode="option">
		<xsl:apply-templates select="code" mode="selectNode" />
		<xsl:apply-templates select="displayName" mode="selectNode" />
	</xsl:template>
	
	<xsl:template match="line" mode="line">
		<xsl:element name="line">
			<xsl:attribute name="sequence">
				<xsl:value-of select="@sequence" />
			</xsl:attribute>
			<xsl:apply-templates select="lineType" mode="selectNode" />
			<!-- Sorted by specific order -->
			<xsl:apply-templates select="content[outlet/element = 'name']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'address']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'commercial']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'telecom']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'email']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'web']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'visual']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'keyword']" mode="line" />
			<xsl:apply-templates select="content[outlet/element = 'social']" mode="line" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="content" mode="line">
		<xsl:variable name="aidRef" select="outlet/aid"/>
		<xsl:choose>
			<xsl:when test="../../../outlet/child::*[@aid = $aidRef]">
				<xsl:apply-templates select="../../../outlet/name[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/address[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/commercial[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/telecom[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/email[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/web[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/visual[@aid = $aidRef]"  mode="selectTree" />	
				<xsl:apply-templates select="../../../outlet/keyword[@aid = $aidRef]"  mode="selectTree" />
				<xsl:apply-templates select="../../../outlet/social[@aid = $aidRef]"  mode="selectTree" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:comment>
						<xsl:value-of select="concat($noContentFoundString, $aidRef)"/>
				</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Default matcher -->
	<xsl:template match="*" />
	
</xsl:stylesheet>
