using System.Globalization;
using System.Xml;
using Microsoft.Azure.Functions.Extensions.Workflows;
using Microsoft.Azure.Functions.Worker;

namespace HarborLane.Integration.Functions;

public static class WorkflowFunctions
{
    [Function("PricingRules_CalculateDiscount")]
    public static PricingResult CalculateDiscount([WorkflowActionTrigger] string total, string? customerTier)
    {
        decimal parsedTotal = decimal.Parse(total, NumberStyles.Number, CultureInfo.InvariantCulture);
        decimal discount = PricingRules.CalculateDiscount(parsedTotal, customerTier);
        return new PricingResult(discount.ToString(CultureInfo.InvariantCulture), (parsedTotal - discount).ToString(CultureInfo.InvariantCulture));
    }

    [Function("ErrorMessageBuilder_BuildOrderError")]
    public static string BuildOrderError([WorkflowActionTrigger] string? flowName, string? orderReference, string? errorText) =>
        ErrorMessageBuilder.BuildOrderError(flowName, orderReference, errorText, DateTime.UtcNow);

    [Function("ShipmentRules_IsValidNotice")]
    public static bool IsValidNotice([WorkflowActionTrigger] string? shipmentId, string? trackingNumber, int packageCount) =>
        ShipmentRules.IsValidNotice(shipmentId, trackingNumber, packageCount);

    [Function("DeliveryCalendar_EstimateDeliveryDate")]
    public static string EstimateDeliveryDate([WorkflowActionTrigger] string shipDate, string? serviceLevel)
    {
        DateTime parsed = DateTime.ParseExact(shipDate, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None);
        return DeliveryCalendar.EstimateDeliveryDate(parsed, serviceLevel);
    }

    [Function("ShipmentRules_AckStatus")]
    public static string AssignAckStatus([WorkflowActionTrigger] bool isValid, string? estimatedDelivery, string ackXml)
    {
        var document = new XmlDocument { PreserveWhitespace = true };
        document.LoadXml(ackXml ?? throw new InvalidDataException("ackXml is required."));
        XmlElement root = document.DocumentElement ?? throw new InvalidDataException("Acknowledgment XML has no root.");
        SetRequiredChild(root, "Status", ShipmentRules.AckStatus(isValid));
        SetRequiredChild(root, "EstimatedDelivery", estimatedDelivery ?? string.Empty);
        return document.OuterXml;
    }

    private static void SetRequiredChild(XmlElement root, string localName, string value)
    {
        XmlElement? child = root.ChildNodes.OfType<XmlElement>().SingleOrDefault(element => element.LocalName == localName);
        if (child is null) throw new InvalidDataException($"ShipmentAck/{localName} is missing.");
        child.InnerText = value;
    }
}

public sealed record PricingResult(string discountAmount, string netTotal);
