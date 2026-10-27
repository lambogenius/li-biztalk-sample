using System;

namespace HarborLane.Integration.Helpers
{
    /// <summary>
    /// Pricing rules for Harbor Lane Supply purchase orders.
    /// Called from the Expr_CalculateDiscount shape in OrderIntakeOrchestration.
    /// </summary>
    public static class PricingRules
    {
        /// <summary>Orders at or above this total are routed to manual approval.</summary>
        public const decimal ManualApprovalThreshold = 5000m;

        /// <summary>
        /// Returns the discount amount (not the percentage) for an order total and a customer tier.
        /// Gold customers get 10%, Silver 5%, Trail (and unknown tiers) 0%.
        /// Orders of 1000 or more get an extra 1% volume discount for every tier.
        /// The result is rounded to two decimals, away from zero.
        /// </summary>
        public static decimal CalculateDiscount(decimal total, string customerTier)
        {
            if (total <= 0m)
            {
                return 0m;
            }

            decimal rate = TierRate(customerTier);
            if (total >= 1000m)
            {
                rate += 0.01m;
            }

            return Math.Round(total * rate, 2, MidpointRounding.AwayFromZero);
        }

        /// <summary>Returns true when an order total needs manual approval.</summary>
        public static bool RequiresApproval(decimal total)
        {
            return total >= ManualApprovalThreshold;
        }

        private static decimal TierRate(string customerTier)
        {
            switch ((customerTier ?? string.Empty).Trim().ToUpperInvariant())
            {
                case "GOLD":
                    return 0.10m;
                case "SILVER":
                    return 0.05m;
                default:
                    return 0m;
            }
        }
    }
}
