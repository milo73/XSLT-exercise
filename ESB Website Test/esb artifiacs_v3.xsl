<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <body>
                <h2>Artifacts</h2>
                <table border="1">
                    <tr bgcolor="#9acd32">
                        <th>Artifact</th>
                        <th>Version</th>
                    </tr>
                    <xsl:for-each select="/routes/*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='route']">
                        <tr>
                            <td><b><xsl:value-of select="*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='maven'][1]/@artifactId"/></b></td>
                            <td><b><xsl:value-of select="*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='maven'][1]/@version"/></b></td>
                        </tr>
                       <xsl:for-each select="/routes/*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='route']/*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='configuration']/*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='properties']">
                            <tr>
                                <td><xsl:value-of select="*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='property'][1]/@key"/></td>
                                <td><xsl:value-of select="*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='property']"/></td>
                            </tr>
                       </xsl:for-each>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
