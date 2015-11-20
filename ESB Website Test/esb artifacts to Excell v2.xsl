<?xml version="1.0" encoding="ISO-8859-1"?>  
<?mso-application progid="Excel.Sheet"?>  
<xsl:stylesheet version="1.0" xmlns:html="http://www.w3.org/TR/REC-html40"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">

    <xsl:template match="/">

        <Workbook>
            <Styles>
                <Style ss:ID="Default" ss:Name="Normal">
                    <Alignment ss:Vertical="Bottom"/>
                    <Borders/>
                    <Font/>
                    <Interior/>
                    <NumberFormat/>
                    <Protection/>
                </Style>
                <Style ss:ID="s21">
                    <Font ss:Size="22" ss:Bold="1"/>
                </Style>
                <Style ss:ID="s22">
                    <Font ss:Size="14" ss:Bold="1"/>
                </Style>
                <Style ss:ID="s23">
                    <Font ss:Size="12" ss:Bold="1"/>
                </Style>
                <Style ss:ID="s24">
                    <Font ss:Size="10" ss:Bold="1"/>
                </Style>
            </Styles>

            <Worksheet ss:Name="{*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='maven'][1]/@artifactId}">
                <Table>
                    <Column ss:AutoFitWidth="0" ss:Width="85"/>
                    <Column ss:AutoFitWidth="0" ss:Width="115"/>
                    <Column ss:AutoFitWidth="0" ss:Width="115"/>
                    <Column ss:AutoFitWidth="0" ss:Width="160"/>
                    <Column ss:AutoFitWidth="0" ss:Width="115"/>
                    <Column ss:AutoFitWidth="0" ss:Width="85"/>
                    <Column ss:AutoFitWidth="0" ss:Width="85"/>
                    <Column ss:AutoFitWidth="0" ss:Width="160"/>

                    <Row ss:AutoFitHeight="0" ss:Height="27.75">
                        <Cell ss:StyleID="s21">
                            <Data ss:Type="String">Example Spreadsheet</Data>
                        </Cell>
                    </Row>
                    <Row ss:AutoFitHeight="0" ss:Height="18">
                        <Cell ss:StyleID="s22">
                            <Data ss:Type="String">
                                ESB Artifacts
                            </Data>
                        </Cell>
                    </Row>
                    <Row>
                        <Cell>
                            <Data ss:Type="String"> </Data>
                        </Cell>
                    </Row>

                    <xsl:call-template name="esbArtifacts"/>


                </Table>
            </Worksheet>
        </Workbook>
    </xsl:template>


    <xsl:template name="esbArtifacts">

        <Row ss:AutoFitHeight="0" ss:Height="18">
            <Cell ss:StyleID="s23">
                <Data ss:Type="String">
                    Artifact
                </Data>
            </Cell>
        </Row>
        <Row>
            <Cell ss:StyleID="s24">
                <Data ss:Type="String">
                    Artifact
                </Data>
            </Cell>
            <Cell ss:StyleID="s24">
                <Data ss:Type="String">
                    Version
                </Data>
            </Cell>
      
        </Row>

        <xsl:for-each select="/routes/*[namespace-uri()='http://schema.detelefoongids.nl' and local-name()='route']">

            <Row>
                <Cell>
                    <Data ss:Type="String">
                        <xsl:value-of select="@artifactId"/>
                    </Data>
                </Cell>
                <Cell>
                    <Data ss:Type="String">
                        <xsl:value-of select="@version"/>
                    </Data>
                </Cell>
            </Row>

        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
