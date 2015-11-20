<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns="http://schema.detelefoongids.nl"
    xmlns:dtg="http://schema.detelefoongids.nl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
>
    <xsl:include href="include/generate-menu.xsl"/>
    <xsl:output method="html" omit-xml-declaration="yes" encoding="utf-8"/>

    <xsl:param name="routeId"/>
    <xsl:param name="jiraURL">https://jira.eurodir.eu/jira/browse/</xsl:param>
    <xsl:key name="supportedProperties" match="dtg:property" use="@key"/>

    <!--+
        | Root matcher, proceed with child nodes.
        +-->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <!--+
        | Routes matcher, generate the HTML page.
        +-->
    <xsl:template match="routes">
        <html>
            <head>
                <title>
                    <xsl:text>DTG ESB Routes</xsl:text>
                </title>
               <link href="/css/stylesheet.css" rel="Stylesheet"/>
            </head>
            <body>
                <div class="header">
                    <div class="header_content">
                        <div class="header_right">
                            <xsl:text>ESB Routes Information</xsl:text>
                        </div>
                    </div>
                    <div class="header_line">
                        <xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
                    </div>
                    <div class="header_shade">
                        <xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
                    </div>
                </div>
                <div class="leftMenuPane">
                    <div class="leftmenu_content">
                        <div class="leftmenu_header">
                            <xsl:text>MENU</xsl:text>
                        </div>
                        <div class="leftmenu_option">
                            <a href="/overview">overview</a>
                        </div>
                        <div class="leftmenuSpacer">
                            <xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
                        </div>
                        <xsl:apply-templates mode="menu">
                            <xsl:with-param name="routeId">
                                <xsl:value-of select="$routeId"/>
                            </xsl:with-param>
                        </xsl:apply-templates>
                    </div>
                </div>
                <div class="contentPane">
                    <xsl:variable name="count">
                        <xsl:value-of select="count(dtg:route[@id=$routeId])"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="count(dtg:route[@id=$routeId]) = 1">
                            <xsl:apply-templates mode="detail" select="dtg:route[@id=$routeId]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <div class="contentPaneSpacer">
                                <h1>
                                    <xsl:text>No route found</xsl:text>
                                </h1>
                                <div class="contentPaneSpacer">
                                    <xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
                                </div>
                                <xsl:text>Sorry, no route data could be found.</xsl:text>
                                <br/>
                                <xsl:text>Report this incident to OPS and/or the ESB dev team.</xsl:text>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--+
        | Route matcher, generated detailed information per route.
        +-->
    <xsl:template match="dtg:route" mode="detail">
        <div class="contentPaneSpacer">
            <h1>
                <xsl:choose>
                    <xsl:when test="@synchronous='true'">
                        <xsl:text>Detailed information about the synchronous route:</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Detailed information about the asynchronous route:</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <br/>
                <xsl:value-of select="@id"/>
            </h1>
            <p/>
            <xsl:apply-templates mode="description"/>
            <xsl:apply-templates mode="detail"/>
        </div>
    </xsl:template>

    <!--+
        | Maven matcher, generate Maven meta data as well as installation instructions.
        +-->
    <xsl:template match="dtg:maven" mode="detail">
        <xsl:variable name="className">
            <xsl:choose>
                <xsl:when test="@configChanged = 'true'">
                    <xsl:text>red</xsl:text>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>

        <h2>
            <xsl:text>Artifact information</xsl:text>
        </h2>
        <xsl:text>The artifact according to the Maven pom notation, which is also used in Nexus.</xsl:text>
        <p/>
        <table>
            <tr>
                <th>
                    <xsl:text>GroupId</xsl:text>
                </th>
                <td>
                    <xsl:value-of select="@groupId"/>
                </td>
            </tr>
            <tr>
                <th>
                    <xsl:text>ArtifactId</xsl:text>
                </th>
                <td>
                    <xsl:value-of select="@artifactId"/>
                </td>
            </tr>
            <tr>
                <th>
                    <xsl:text>Version</xsl:text>
                </th>
                <td>
                    <xsl:value-of select="@version"/>
                </td>
            </tr>
            <tr>
                <th>
                    <xsl:text>Feature</xsl:text>
                </th>
                <td>
                    <xsl:value-of select="@feature"/>
                </td>
            </tr>
            <tr>
                <th>
                    <xsl:text>Configuration Changed</xsl:text>
                </th>
                <xsl:element name="td">
                    <xsl:if test="$className != ''">
                        <xsl:attribute name="class">
                            <xsl:value-of select="$className"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="@configChanged"/>
                </xsl:element>
            </tr>
        </table>
        <p/>
    </xsl:template>

    <!--+
        | Notes matcher, generate table.
        +-->
    <xsl:template match="dtg:notes" mode="detail">
        <h2>
            <xsl:text>Notes</xsl:text>
        </h2>
        <table>
            <tr>
                <th>
                    <xsl:text>Date</xsl:text>
                </th>
                <th>
                    <xsl:text>Description</xsl:text>
                </th>
            </tr>
            <xsl:apply-templates mode="detail"/>
        </table>
    </xsl:template>
    
    <!--+
        | Note matcher, generate table row.
        +-->
    <xsl:template match="dtg:note" mode="detail">
        <tr>
            <td>
                <xsl:value-of select="@date"/>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <!--+
        | Configuration matcher, generate configuration meta data.
        +-->
    <xsl:template match="dtg:configuration" mode="detail">
        <h2>
            <xsl:text>Configuration</xsl:text>
        </h2>
        <xsl:text>Below the actual values configured on this environment are displayed.</xsl:text>
        <p/>
        <xsl:apply-templates mode="detail"/>
    </xsl:template>

    <!--+
        | Properties matcher, generate table.
        +-->
    <xsl:template match="dtg:properties" mode="detail">
        <h3>
            <xsl:value-of select="concat('Properties of ', @fileReference)"/>
        </h3>
        <xsl:apply-templates mode="detail"/>
    </xsl:template>

    <!--+
        | Property matcher, generate table row.
        +-->
    <xsl:template match="dtg:property" mode="detail">
        <xsl:variable name="className">
            <xsl:choose>
                <xsl:when test="@constant='true' and @changed='true'">
                    <xsl:text>constantRed</xsl:text>
                </xsl:when>
                <xsl:when test="@constant='true' and @changed='false'">
                    <xsl:text>constant</xsl:text>
                </xsl:when>
                <xsl:when test="@constant='false' and @changed='true'">
                    <xsl:text>changed</xsl:text>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <table width="100%">
            <tr>
                <xsl:element name="th">
                    <xsl:if test="$className != ''">
                        <xsl:attribute name="class">
                            <xsl:value-of select="$className"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:attribute name="colspan">
                        <xsl:text>2</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="@key"/>
                </xsl:element>
            </tr>
            <tr>
                <th width="20%">Description</th>
                <td width="80%"><xsl:value-of select="@description"/></td>
            </tr>
            <tr>
                <th>Example Value</th>
                <td><xsl:value-of select="@exampleValue"/></td>
            </tr>
            <tr>
                <th>Current Value</th>
                <td><xsl:value-of select="."/></td>
            </tr>
        </table>
        <p/>
    </xsl:template>

    <!--+
        | Generate info about allowed messages
        +-->
    <xsl:template match="dtg:allowedMessages" mode="detail">
        <h2>
            <xsl:text>AllowedMessages</xsl:text>
        </h2>
        <xsl:text>This artifact makes use of the allowedMessages.</xsl:text>
        <br/>
        <xsl:text>The configuration related to this version can be found here:</xsl:text>
        <p/>
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
            <xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
        <p/>
        <p/>
    </xsl:template>

    <!--+
        | Description matcher, generate description meta data.
        +-->
    <xsl:template match="dtg:description" mode="description">
        <h2>
            <xsl:text>Description</xsl:text>
        </h2>
        <xsl:apply-templates mode="paragraph"/>
        <xsl:apply-templates select="../dtg:routeImageURL" mode="routeImage"/>
        <p/>
    </xsl:template>

    <xsl:template match="dtg:paragraph" mode="paragraph">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
        <!--+
		 | Route Image matcher : <img src="http://huisartsenmolenwijk.nl/./templates/247extender_c/images/space.gif" width="760" height="1" />
         +-->
    <xsl:template match="dtg:routeImageURL" mode="routeImage">
		<h2>
			<xsl:text>Route overview</xsl:text>
        </h2>
		<xsl:element name="img">
			<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
		</xsl:element>
    </xsl:template>

    <xsl:template match="dtg:history" mode="description">
        <h2>
            <xsl:text>Version history</xsl:text>
        </h2>
        <xsl:text>The following versions have been released.</xsl:text>
        <p/>
        <table>
            <tr>
                <th>
                    <xsl:text>Version</xsl:text>
                </th>
                <th>
                    <xsl:text>Changes</xsl:text>
                </th>
            </tr>
            <xsl:apply-templates mode="description"/>
        </table>
        <p/>
    </xsl:template>

    <!--+
        | Changes
        +-->
    <xsl:template match="dtg:changes" mode="description">
        <xsl:apply-templates mode="description"/>
    </xsl:template>

    <!--+
        | Change
        +-->
    <xsl:template match="dtg:change" mode="description">
        <tr>
            <td>
                <xsl:choose>
                    <xsl:when test="count(preceding-sibling::*) = 0">
                        <xsl:value-of select="../@version"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text disable-output-escaping="yes"><![CDATA[&#160;]]></xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="@jira">
                        <xsl:element name="a">
                            <xsl:attribute name="class"><xsl:text>jiraItem</xsl:text></xsl:attribute>
                            <xsl:attribute name="href"><xsl:value-of select="concat($jiraURL, @jira)"/></xsl:attribute>
                            <xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute>
                            <xsl:value-of select="concat('Jira: ', .)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>

    <!--+
        | Endpoints:
        +-->
    <xsl:template match="dtg:endpoints" mode="description">
        <h2>
            <xsl:text>Endpoints</xsl:text>
        </h2>
        <xsl:text>The following endpoints have been defined.</xsl:text>
        <p/>
        <xsl:apply-templates mode="description"/>
        <p/>
    </xsl:template>

    <xsl:template match="dtg:endpoint" mode="description">
        <h3>
            <xsl:value-of select="concat(@direction, ' ', @archeType)"/>
        </h3>
        <table>
            <tr>
                <xsl:element name="td">
                    <xsl:attribute name="class"><xsl:value-of select="concat('archeType ', @subType)"/></xsl:attribute>
                    <xsl:value-of select="@subType"/>
                </xsl:element>
                <td>
                    <xsl:apply-templates mode="description"/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!--+
        | Certificates:
        +-->
    <xsl:template match="dtg:certificates" mode="description">
        <h3 class="endPointTitle">
            <xsl:text>Certificates</xsl:text>
        </h3>
        <table>
            <tr>
                <th>
                    <xsl:text>Type</xsl:text>
                </th>
                <th>
                    <xsl:text>Expiry Date</xsl:text>
                </th>
            </tr>
            <xsl:apply-templates mode="description"/>
        </table>
    </xsl:template>

    <xsl:template match="dtg:certificate" mode="description">
        <tr>
            <td>
                <xsl:value-of select="."/>
            </td>
            <td>
                <xsl:value-of select="@expiryDate"/>
            </td>
        </tr>
    </xsl:template>

    <!--+
        | Schemas:
        +-->
    <xsl:template match="dtg:schemas" mode="description">
        <h3 class="endPointTitle">
            <xsl:text>Schemas</xsl:text>
        </h3>
        <table>
            <tr>
                <th>
                    <xsl:text>Name</xsl:text>
                </th>
                <th>
                    <xsl:text>Version</xsl:text>
                </th>
                <th>
                    <xsl:text>Validating</xsl:text>
                </th>
            </tr>
            <xsl:apply-templates mode="description"/>
        </table>
    </xsl:template>

    <xsl:template match="dtg:schema" mode="description">
        <tr>
            <td>
                <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
                    <xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute>
                    <xsl:value-of select="@type"/>
                </xsl:element>
            </td>
            <td>
                <xsl:value-of select="@version"/>
            </td>
            <td>
                <xsl:value-of select="@validating"/>
            </td>
        </tr>
    </xsl:template>

    <!--+
        | Associated properties:
        +-->
    <xsl:template match="dtg:associatedProperties" mode="description">
        <h3 class="endPointTitle">
            <xsl:text>Properties</xsl:text>
        </h3>
        <table>
            <tr>
                <th>
                    <xsl:text>Name</xsl:text>
                </th>
                <th>
                    <xsl:text>Value</xsl:text>
                </th>
            </tr>
            <xsl:apply-templates mode="description"/>
        </table>
    </xsl:template>

    <xsl:template match="dtg:associatedProperty" mode="description">
        <xsl:variable name="keyName">
            <xsl:value-of select="@key"/>
        </xsl:variable>
        <tr>
            <td>
                <xsl:value-of select="@key"/>
            </td>
            <td>
                <xsl:value-of select="key('supportedProperties', @key)"/>
            </td>
        </tr>
    </xsl:template>

    <!--+
        | Label matcher, generate table row.
        +-->
    <xsl:template match="dtg:label" mode="description">
        <tr>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <!--+
        | Depending routes matcher, generate table.
        +-->
    <xsl:template match="dtg:dependingRoutes" mode="description">
        <h2>
            <xsl:text>Depending routes</xsl:text>
        </h2>
        <xsl:text>This route depends on other routes in order to make a full working chain.</xsl:text>
        <p/>
        <table>
            <tr>
                <th>
                    <xsl:text>Route</xsl:text>
                </th>
            </tr>
            <xsl:apply-templates mode="description"/>
        </table>
        <p/>
    </xsl:template>

    <!--+
        | Esbroute matcher, generate table row.
        +-->
    <xsl:template match="dtg:esbRoute" mode="description">
        <tr>
            <td>
                <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="concat('/detail?routeId=', @id)"/></xsl:attribute>
                    <xsl:value-of select="@id"/>
                </xsl:element>
            </td>
        </tr>
    </xsl:template>
    <!-- Default matchers -->
    <xsl:template match="dtg:*" mode="description"/>
    <xsl:template match="dtg:*" mode="detail"/>
    <xsl:template match="dtg:*" mode="paragraph"/>
    <xsl:template match="dtg:*" mode="routeImage"/>
    <xsl:template match="dtg:*"/>
    <xsl:template match="*"/>
</xsl:stylesheet>
