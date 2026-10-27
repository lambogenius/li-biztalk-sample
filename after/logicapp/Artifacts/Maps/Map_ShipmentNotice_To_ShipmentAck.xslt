<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sn="http://HarborLane.Integration.Schemas.ShipmentNotice" xmlns:ack="http://HarborLane.Integration.Schemas.ShipmentAck" exclude-result-prefixes="sn xs">
  <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:template match="/sn:ShipmentNotice"><ack:ShipmentAck><ShipmentId><xsl:value-of select="ShipmentId"/></ShipmentId><OrderNumber><xsl:value-of select="OrderNumber"/></OrderNumber><Status>Pending</Status><EstimatedDelivery>Pending</EstimatedDelivery><ReceivedAt><xsl:value-of select="format-dateTime(adjust-dateTime-to-timezone(current-dateTime(), xs:dayTimeDuration('PT0H')), '[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01]Z')"/></ReceivedAt></ack:ShipmentAck></xsl:template>
</xsl:stylesheet>
