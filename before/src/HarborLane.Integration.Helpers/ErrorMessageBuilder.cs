using System;
using System.Globalization;
using System.Xml;

namespace HarborLane.Integration.Helpers
{
    /// <summary>
    /// Builds error messages that conform to the OrderError schema
    /// (http://HarborLane.Integration.Schemas.OrderError).
    /// Called from the exception handler in OrderIntakeOrchestration.
    /// </summary>
    public static class ErrorMessageBuilder
    {
        /// <summary>Target namespace of the OrderError schema.</summary>
        public const string OrderErrorNamespace = "http://HarborLane.Integration.Schemas.OrderError";

        /// <summary>
        /// Returns an OrderError document:
        /// &lt;ns0:OrderError&gt;&lt;FlowName/&gt;&lt;OrderReference/&gt;&lt;ErrorMessage/&gt;&lt;OccurredAt/&gt;&lt;/ns0:OrderError&gt;
        /// </summary>
        public static XmlDocument BuildOrderError(string flowName, string orderReference, string errorText)
        {
            return BuildOrderError(flowName, orderReference, errorText, DateTime.UtcNow);
        }

        /// <summary>Same as <see cref="BuildOrderError(string,string,string)"/> with an explicit timestamp.</summary>
        public static XmlDocument BuildOrderError(string flowName, string orderReference, string errorText, DateTime occurredAtUtc)
        {
            var document = new XmlDocument();
            XmlElement root = document.CreateElement("ns0", "OrderError", OrderErrorNamespace);
            document.AppendChild(root);

            AppendChild(document, root, "FlowName", flowName);
            AppendChild(document, root, "OrderReference", orderReference);
            AppendChild(document, root, "ErrorMessage", errorText);
            AppendChild(
                document,
                root,
                "OccurredAt",
                occurredAtUtc.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ", CultureInfo.InvariantCulture));

            return document;
        }

        private static void AppendChild(XmlDocument document, XmlElement parent, string name, string value)
        {
            // Child elements are unqualified (elementFormDefault is not set in the schema).
            XmlElement child = document.CreateElement(name);
            child.InnerText = value ?? string.Empty;
            parent.AppendChild(child);
        }
    }
}
