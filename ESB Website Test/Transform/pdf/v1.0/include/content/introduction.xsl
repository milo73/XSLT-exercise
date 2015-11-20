<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:dtg="http://schema.detelefoongids.nl"
>
	
	<!--+
		| [/] <introduction>
		| Generate content for introduction
		+-->
	<xsl:template match="/" mode="introduction">
		
		<fo:block id="toc_introduction_x">
			
			<!-- Description -->
			<fo:block id="{$toc_introduction_description}" font-weight="bold" font-size="16pt">
				<xsl:value-of select="$toc_introduction_description"/>
			</fo:block>
			<xsl:choose>
				<xsl:when test="count(dtg:route/dtg:description/dtg:paragraph) = 0">
					<fo:block>
						<xsl:text>Currently, no description is set</xsl:text>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="dtg:route/dtg:description/dtg:paragraph" mode="introduction"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- History -->
			<fo:block id="{$toc_introduction_history}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_introduction_history"/>
			</fo:block>
			<xsl:choose>
				<xsl:when test="count(dtg:route/dtg:history/dtg:changes) = 0">
					<fo:block>
						<xsl:text>Currently, no history is known</xsl:text>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="dtg:route/dtg:history/dtg:changes" mode="introduction"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Notes -->
			<fo:block id="{$toc_introduction_notes}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_introduction_notes"/>
			</fo:block>
			<xsl:choose>
				<xsl:when test="count(dtg:route/dtg:notes/dtg:note) = 0">
					<fo:block>
						<xsl:text>Currently, no notes are present</xsl:text>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="dtg:route/dtg:notes/dtg:note" mode="introduction"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Endpoints -->
			<fo:block id="{$toc_introduction_endpoints}" font-weight="bold" font-size="16pt" margin-top="1cm">
				<xsl:value-of select="$toc_introduction_endpoints"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="concat('This route has ', count(dtg:route/dtg:endpoints/dtg:endpoint), ' endpoints defined')"/>
			</fo:block>
			<xsl:apply-templates select="dtg:route/dtg:endpoints/dtg:endpoint" mode="introduction"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="dtg:paragraph" mode="introduction">
		<fo:block margin-top="5mm">
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="dtg:changes" mode="introduction">
		<fo:block margin-top="5mm">
			<fo:table width="100%">
				<fo:table-column column-width="100%"/>
				
				<fo:table-header>
					<fo:table-cell padding-top="3pt" padding-bottom="3pt">
						<fo:block font-weight="bold">
							<xsl:value-of select="concat('Changes since version: ', @version)"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-header>
				
				<fo:table-body>
					<xsl:apply-templates mode="introduction"/>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="dtg:change" mode="introduction">
		<fo:table-row>
			<fo:table-cell>
				<fo:block>
					<xsl:choose>
						<xsl:when test="@jira">
							<xsl:variable name="generatedLink">
								<xsl:value-of select="concat($jiraHost, @jira)"/>
							</xsl:variable>
							<xsl:text>- Jira issue </xsl:text>
							<fo:basic-link external-destination="{$generatedLink}" text-decoration="underline">
								<xsl:value-of select="@jira"/>
							</fo:basic-link>
							<xsl:value-of select="concat(': ', .)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('- ', .)"/>
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<xsl:template match="dtg:note" mode="introduction">
		<fo:block>
			<xsl:choose>
				<xsl:when test="@date">
					<xsl:value-of select="concat('- ', @date, ': ', .)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('- ', .)"/>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	
	<!-- <endpoint direction="from" archeType="webservice" subType="SOAP"> -->
	<xsl:template match="dtg:endpoint" mode="introduction">
		<fo:block>
			<xsl:value-of select="concat('- ', @direction, ' of type: ', @archeType, ' with sub type: ', @subType)"/>
		</fo:block>
	</xsl:template>
	
	<!--+
		| [*] <introduction>
		| Default matcher -> absorb
		+-->
	<xsl:template match="*" mode="introduction"/>
	
</xsl:stylesheet>
