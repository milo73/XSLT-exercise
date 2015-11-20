<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                       xmlns:xs="http://www.w3.org/2001/XMLSchema"        
                       version="2.0">
                       
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="superProfileVersion" select="'V1.1'"/>
	<xsl:param name="outletVersion" select="'V2.3'"/>
	<xsl:param name="noContentFoundString" select="'No content found for: '"/>
	
	<!--+
	      | This stylesheet transforms a commandToPublish composition message into a commandToPublish seaPublication.		 
		  +-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="commandToPublish">
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
		<xsl:element name="superProfile">
			<xsl:attribute name="version"><xsl:value-of select="$superProfileVersion"/></xsl:attribute>
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
			<!--+
				 | For the current version of the XSD the outlet element requires an version attribute.
				 | This is unwanted behaviour and the version attribute will be removed in a future version.
				 | For now, we hardcode the attribute, so that it can be easily removed in the future.
				 +-->
			<xsl:attribute name="version"><xsl:value-of select="$outletVersion"/></xsl:attribute>
			<xsl:apply-templates select="../outlet/outletId" mode="selectNode" />
			<xsl:apply-templates select="line" mode="line" />
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
				<xsl:apply-templates select="../../../outlet/email[@aid = $aidRef]"  mode="selectTree" />					
				<xsl:apply-templates select="../../../outlet/visual[@aid = $aidRef]"  mode="selectTree" />			
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
	
</xsl:stylesheet>
