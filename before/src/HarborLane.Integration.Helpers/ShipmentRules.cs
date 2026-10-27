using System;

namespace HarborLane.Integration.Helpers
{
    /// <summary>
    /// Validation and transit rules for carrier shipment notices.
    /// Called from ShipmentNotificationOrchestration.
    /// </summary>
    public static class ShipmentRules
    {
        /// <summary>Acknowledgment status for a notice that passed validation.</summary>
        public const string Accepted = "Accepted";

        /// <summary>Acknowledgment status for a notice that failed validation.</summary>
        public const string Rejected = "Rejected";

        /// <summary>
        /// Transit time in business days for a service level:
        /// Express 2, Ground 5, Freight 8. Unknown levels are treated as Ground.
        /// </summary>
        public static int GetTransitBusinessDays(string serviceLevel)
        {
            switch ((serviceLevel ?? string.Empty).Trim().ToUpperInvariant())
            {
                case "EXPRESS":
                    return 2;
                case "FREIGHT":
                    return 8;
                default:
                    return 5;
            }
        }

        /// <summary>
        /// A notice is valid when it has a shipment id, a tracking number of at least
        /// 8 characters, and between 1 and 99 packages.
        /// </summary>
        public static bool IsValidNotice(string shipmentId, string trackingNumber, int packageCount)
        {
            if (string.IsNullOrWhiteSpace(shipmentId))
            {
                return false;
            }

            if (string.IsNullOrWhiteSpace(trackingNumber) || trackingNumber.Trim().Length < 8)
            {
                return false;
            }

            return packageCount >= 1 && packageCount <= 99;
        }

        /// <summary>Returns the acknowledgment status text for a validation result.</summary>
        public static string AckStatus(bool isValid)
        {
            return isValid ? Accepted : Rejected;
        }
    }
}
