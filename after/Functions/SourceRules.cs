using System.Globalization;
using System.Xml;

namespace HarborLane.Integration.Functions;

public static class PricingRules
{
    public const decimal ManualApprovalThreshold = 5000m;

    public static decimal CalculateDiscount(decimal total, string? customerTier)
    {
        if (total <= 0m) return 0m;
        decimal rate = (customerTier ?? string.Empty).Trim().ToUpperInvariant() switch
        {
            "GOLD" => 0.10m,
            "SILVER" => 0.05m,
            _ => 0m
        };
        if (total >= 1000m) rate += 0.01m;
        return Math.Round(total * rate, 2, MidpointRounding.AwayFromZero);
    }
}

public static class ShipmentRules
{
    public const string Accepted = "Accepted";
    public const string Rejected = "Rejected";

    public static int GetTransitBusinessDays(string? serviceLevel) =>
        (serviceLevel ?? string.Empty).Trim().ToUpperInvariant() switch
        {
            "EXPRESS" => 2,
            "FREIGHT" => 8,
            _ => 5
        };

    public static bool IsValidNotice(string? shipmentId, string? trackingNumber, int packageCount)
    {
        if (string.IsNullOrWhiteSpace(shipmentId)) return false;
        if (string.IsNullOrWhiteSpace(trackingNumber) || trackingNumber.Trim().Length < 8) return false;
        return packageCount >= 1 && packageCount <= 99;
    }

    public static string AckStatus(bool isValid) => isValid ? Accepted : Rejected;
}

public static class DeliveryCalendar
{
    public static DateTime AddBusinessDays(DateTime start, int businessDays)
    {
        if (businessDays < 0) throw new ArgumentOutOfRangeException(nameof(businessDays), "Business days must be zero or more.");
        DateTime current = start.Date;
        while (IsWeekend(current)) current = current.AddDays(1);
        int added = 0;
        while (added < businessDays)
        {
            current = current.AddDays(1);
            if (!IsWeekend(current)) added++;
        }
        return current;
    }

    public static string EstimateDeliveryDate(DateTime shipDate, string? serviceLevel) =>
        AddBusinessDays(shipDate, ShipmentRules.GetTransitBusinessDays(serviceLevel)).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

    private static bool IsWeekend(DateTime date) => date.DayOfWeek is DayOfWeek.Saturday or DayOfWeek.Sunday;
}

public static class ErrorMessageBuilder
{
    public const string OrderErrorNamespace = "http://HarborLane.Integration.Schemas.OrderError";

    public static string BuildOrderError(string? flowName, string? orderReference, string? errorText, DateTime occurredAtUtc)
    {
        var document = new XmlDocument();
        XmlElement root = document.CreateElement("ns0", "OrderError", OrderErrorNamespace);
        document.AppendChild(root);
        AppendChild(document, root, "FlowName", flowName);
        AppendChild(document, root, "OrderReference", orderReference);
        AppendChild(document, root, "ErrorMessage", errorText);
        AppendChild(document, root, "OccurredAt", occurredAtUtc.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ", CultureInfo.InvariantCulture));
        return document.OuterXml;
    }

    private static void AppendChild(XmlDocument document, XmlElement parent, string name, string? value)
    {
        XmlElement child = document.CreateElement(name);
        child.InnerText = value ?? string.Empty;
        parent.AppendChild(child);
    }
}
