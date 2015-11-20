<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                       xmlns:xs="http://www.w3.org/2001/XMLSchema"        
                       version="2.0">
                       
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="superProfileVersion" select="'V1.2'"/>	
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
         | Replace the composition element with the superProfile element and set the appropiate version
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
			<xsl:apply-templates select="../outlet/outletId" mode="selectNode" />
			<!--+
				 | Order the content of the installbase not based on linesequence, but on
				 | name, address, telecom, web, email, visual
				 +-->
			<xsl:apply-templates select="line/content/outlet[element/text() = 'name']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'address']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'telecom']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'web']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'email']" mode="contentSelect" />
			<xsl:apply-templates select="line/content/outlet[element/text() = 'visual']" mode="contentSelect" />
		</xsl:element>
		
	</xsl:template>
		
	<xsl:template match="outlet" mode="contentSelect">
		<xsl:variable name="aidRef" select="aid"/>
		<xsl:apply-templates select="../../../../outlet/node()[@aid = $aidRef]"  mode="selectTree" />	
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
