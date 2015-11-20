<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <content>
		| Generate content for configuration
		+-->
	<xsl:template match="/" mode="configuration">
		<xsl:variable name="anyProperties">
			<xsl:value-of select="count(dtg:route/dtg:configuration/dtg:properties)"/>
		</xsl:variable>
	
		<fo:block id="toc_configuration_x">
			
			<!-- Properties -->
			<xsl:choose>
				<xsl:when test="$anyProperties &gt; 0">
					<!--+
						| Generate extra line in case the configuration has changed
						+-->
					<xsl:if test="dtg:route/dtg:maven/@configChanged = 'true'">
						<fo:block color="red">
							<xsl:text>Note that the configuration has changed in this release!</xsl:text>
						</fo:block>
					</xsl:if>
					<!--+
						| Generate a block for each property file
						+-->	
					<xsl:apply-templates select="dtg:route/dtg:configuration/dtg:properties" mode="configuration"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>This route has no properties defined.</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Allowed messages -->
			<xsl:if test="dtg:route/dtg:allowedMessages">
				<xsl:apply-templates select="dtg:route/dtg:allowedMessages" mode="configuration"/>
			</xsl:if>
		</fo:block>
		
	</xsl:template>
	
	<xsl:template match="dtg:properties" mode="configuration">
		<fo:block margin-top="5mm">
			<!--+
				| Each properties section contains:
				| - id
				| - fileReference
				+-->
			<fo:table width="100%" border="solid black 1px">
				<fo:table-column column-width="100%"/>
				
				<fo:table-header>
					<fo:table-cell padding-top="3pt" padding-bottom="3pt">
						<fo:block font-weight="bold">
							<xsl:value-of select="concat('Property file name: ', @fileReference)"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-header>
				
				<fo:table-body>
					<xsl:apply-templates mode="configuration"/>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="dtg:property" mode="configuration">
		<xsl:variable name="constant">
			<xsl:choose>
				<xsl:when test="@constant">
					<xsl:value-of select="@constant"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--+
			| Each property contains:
			| - key
			| - secret (to be filtered by website, not release doc)
			| - constant
			| - description
			| - exampleValue
			+-->
		<fo:table-row>
			<fo:table-cell padding-top="3pt" padding-bottom="3pt">
				<fo:block margin-left="5mm">
					<fo:table width="98%" border="solid grey 1px">
						<fo:table-column column-width="100%"/>
						<fo:table-body>
							
							<!-- Key -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="concat('Key: ', @key)"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							
							<!-- Value -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="concat('Value (constant: ', $constant, '): ', .)"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							
							<!-- Description -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="concat('Description: ', @description)"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							
							<!-- Example value -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="concat('Example: ', @exampleValue)"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="dtg:allowedMessages" mode="configuration">
		<fo:block font-weight="bold">
			<xsl:text>Allowed messages configuration:</xsl:text>
		</fo:block>
		<fo:block>
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	
	<!--+
		| [*] <configuration>
		| Default matcher -> absorb
		+-->
	<xsl:template match="*" mode="configuration"/>
	
</xsl:stylesheet>
