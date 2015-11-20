<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <body>
                <h2>Artifacts</h2>
                <table border="1">
                    <tr bgcolor="#9acd32">
                        <th>Message</th>
                        <th>Version</th>
                    </tr>

                    <xsl:for-each select="/messageConfigurations/messageConfiguration[*]">
                        <tr>
                            <td>
                                <b>
                                    <xsl:value-of select="@rootElement"/>
                                </b>
                            </td>
                            <td>
                                <b>
                                    <xsl:value-of select="@messageVersion"/>
                                </b>
                            </td>
                        </tr>

                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
