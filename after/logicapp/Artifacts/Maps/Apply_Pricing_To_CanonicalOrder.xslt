<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:co="http://HarborLane.Integration.Schemas.CanonicalOrder" exclude-result-prefixes="co">
  <xsl:param name="discountAmount"/><xsl:param name="netTotal"/><xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:template match="@*|node()"><xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy></xsl:template>
  <xsl:template match="co:CanonicalOrder/DiscountAmount"><DiscountAmount><xsl:value-of select="$discountAmount"/></DiscountAmount></xsl:template>
  <xsl:template match="co:CanonicalOrder/NetTotal"><NetTotal><xsl:value-of select="$netTotal"/></NetTotal></xsl:template>
</xsl:stylesheet>
