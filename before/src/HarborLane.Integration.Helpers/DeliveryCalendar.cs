using System;
using System.Globalization;

namespace HarborLane.Integration.Helpers
{
    /// <summary>
    /// Business-day arithmetic for shipment ETAs. Weekends are not business days.
    /// Called from the Expr_ValidateAndComputeEta shape in ShipmentNotificationOrchestration.
    /// </summary>
    public static class DeliveryCalendar
    {
        /// <summary>
        /// Adds a number of business days (Monday to Friday) to a date.
        /// A start date on a weekend counts from the following Monday.
        /// </summary>
        public static DateTime AddBusinessDays(DateTime start, int businessDays)
        {
            if (businessDays < 0)
            {
                throw new ArgumentOutOfRangeException("businessDays", "Business days must be zero or more.");
            }

            DateTime current = start.Date;
            while (IsWeekend(current))
            {
                current = current.AddDays(1);
            }

            int added = 0;
            while (added < businessDays)
            {
                current = current.AddDays(1);
                if (!IsWeekend(current))
                {
                    added++;
                }
            }

            return current;
        }

        /// <summary>
        /// Returns the estimated delivery date (yyyy-MM-dd) for a ship date and a service level.
        /// </summary>
        public static string EstimateDeliveryDate(DateTime shipDate, string serviceLevel)
        {
            int transitDays = ShipmentRules.GetTransitBusinessDays(serviceLevel);
            return AddBusinessDays(shipDate, transitDays).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        }

        private static bool IsWeekend(DateTime date)
        {
            return date.DayOfWeek == DayOfWeek.Saturday || date.DayOfWeek == DayOfWeek.Sunday;
        }
    }
}
