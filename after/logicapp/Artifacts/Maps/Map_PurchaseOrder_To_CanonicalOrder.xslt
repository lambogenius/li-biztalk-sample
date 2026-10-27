<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:po="http://HarborLane.Integration.Schemas.PurchaseOrder" xmlns:co="http://HarborLane.Integration.Schemas.CanonicalOrder" exclude-result-prefixes="po xs">
  <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:template match="/po:PurchaseOrder"><co:CanonicalOrder>
    <OrderId><xsl:value-of select="Header/OrderNumber"/></OrderId>
    <OrderDate><xsl:call-template name="format-date"><xsl:with-param name="value" select="Header/OrderDate"/></xsl:call-template></OrderDate>
    <CustomerId><xsl:value-of select="Header/CustomerId"/></CustomerId>
    <CustomerName><xsl:value-of select="concat(Buyer/FirstName, ' ', Buyer/LastName)"/></CustomerName>
    <CustomerEmail><xsl:value-of select="Buyer/Email"/></CustomerEmail><CustomerTier><xsl:value-of select="Header/CustomerTier"/></CustomerTier><Currency><xsl:value-of select="Header/Currency"/></Currency><OrderTotal><xsl:value-of select="Header/TotalAmount"/></OrderTotal>
    <DiscountAmount>0.00</DiscountAmount><NetTotal>0.00</NetTotal><Status>Received</Status>
    <ShippingAddress><xsl:value-of select="concat(ShipTo/Street, ', ', ShipTo/City, ', ', ShipTo/Region, ' ', ShipTo/PostalCode, ', ', ShipTo/Country)"/></ShippingAddress>
    <Items><xsl:for-each select="Lines/Line"><Item><LineNumber><xsl:value-of select="LineNumber"/></LineNumber><Sku><xsl:value-of select="Sku"/></Sku><Description><xsl:value-of select="Description"/></Description><Quantity><xsl:value-of select="Quantity"/></Quantity><UnitPrice><xsl:value-of select="UnitPrice"/></UnitPrice></Item></xsl:for-each></Items>
  </co:CanonicalOrder></xsl:template>
  <xsl:template name="format-date"><xsl:param name="value"/><xsl:choose><xsl:when test="string-length($value)=8 and translate($value, '0123456789', '')='' and concat(substring($value,1,4), '-', substring($value,5,2), '-', substring($value,7,2)) castable as xs:date"><xsl:value-of select="concat(substring($value,1,4), '-', substring($value,5,2), '-', substring($value,7,2))"/></xsl:when><xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise></xsl:choose></xsl:template>
</xsl:stylesheet>
