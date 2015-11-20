<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:output omit-xml-declaration="yes"/>

	<!--+
	      | This stylesheet transforms a commandToPublish composition message into a commandToPublish listingPublication.		 
		  +-->

	<xsl:template match="/">		
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="commandToPublish">
	TEST
		<xsl:copy/>
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="composition">
		<xsl:element name="listingPublication">
			<xsl:attribute name="version">V1.0</xsl:attribute>
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>
		
	<xsl:template match="installBase">
			<xsl:apply-templates select="externId" mode="selectValue"/>
			<xsl:apply-templates select="status" mode="selectValue"/>
			<xsl:apply-templates select="account"  mode="selectTree" />			
			<xsl:apply-templates select="order/main" mode="main"/>		
			<xsl:apply-templates select="order/option" mode="option"/>	
			
			<!-- TODO: Check whether this path really exists. It looks like it should select order/listing/ranking instead -->			 
			<xsl:if test="listing/ranking">			 
				<xsl:apply-templates select="listing/ranking"  mode="selectTree" />	
			</xsl:if>
			 
			<xsl:if test="placement/heading">
				<xsl:apply-templates select="placement/heading"  mode="selectTree" />	
			</xsl:if>	

			<xsl:apply-templates select="placement/targetArea"  mode="selectTree" />	

			<xsl:if test="order/listing/edition">
				<xsl:apply-templates select="order/listing/edition"  mode="selectTree" />	
			</xsl:if>		
			<xsl:apply-templates select="line" mode="line"/>
	</xsl:template>
	
	<xsl:template match="*"  mode="selectValue">
		<!--	TODO: <xsl:copy-of select="."  /> Dit geeft namespace problemen....-->
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
		<xsl:apply-templates select="code" mode="selectValue" />
		<xsl:apply-templates select="displayName" mode="selectValue" />
	</xsl:template>
	
	<xsl:template match="option" mode="option">
		<xsl:element name="optionProduct">
			<xsl:apply-templates mode="option"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="product" mode="option">
		<xsl:apply-templates select="code" mode="selectValue" />
		<xsl:apply-templates select="displayName" mode="selectValue" />
	</xsl:template>
	
	<xsl:template match="line" mode="line">
		<xsl:element name="line">
			<xsl:attribute name="sequence">
				<xsl:value-of select="@sequence" />
			</xsl:attribute>
			<xsl:apply-templates select="name"  mode="selectTree" />	
			<xsl:apply-templates select="address"  mode="selectTree" />	
			<xsl:apply-templates select="commercial"  mode="selectTree" />	
			<xsl:apply-templates select="telecom"  mode="selectTree" />	
			<xsl:apply-templates select="email"  mode="selectTree" />	
			<xsl:apply-templates select="web"  mode="selectTree" />	
			<xsl:apply-templates select="visual"  mode="selectTree" />	
			<xsl:apply-templates select="keyword"  mode="selectTree" />	
		</xsl:element>	

	</xsl:template>
	
	<!-- Default matcher -->
	<xsl:template match="*" />
	
</xsl:stylesheet>
