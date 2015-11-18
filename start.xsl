<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">

    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="personDetails">
        <xsl:element name="orderedList">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="names">
        <xsl:apply-templates>
            <xsl:sort select="id" order="ascending"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="name">
        <xsl:element name="personDetails">
            <!--Get names-->
            <xsl:apply-templates mode="name"/> 
            <!--Get address id--> 
            <xsl:variable name="idRef" select="id"/>
<!--            <xsl:comment><xsl:value-of select="$idRef"/></xsl:comment>-->
            <!--address-->
            <xsl:apply-templates select="../../addresses/address[id=$idRef]" mode="address"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="firstName|lastName" mode="name">
        <xsl:element name="{local-name()}">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="address" mode="address">
        <xsl:apply-templates mode="address"/>
    </xsl:template>

    <xsl:template match="streetName|houseNumber|postalCode|city|description" mode="address">
        <xsl:element name="{local-name()}">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <!--+
        | Default matcher : Absorb
        +-->
    <xsl:template match="*"/>
    <xsl:template match="*" mode="name"/>
    <xsl:template match="*" mode="address"/>
    <xsl:strip-space elements="*"/>
</xsl:stylesheet>
