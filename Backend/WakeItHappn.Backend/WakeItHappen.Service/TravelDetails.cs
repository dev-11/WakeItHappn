using System.Collections.Generic;

namespace WakeItHappen.Service
{
    public class TravelDetails
    {
        public IEnumerable<Route> Steps { get; set; }
    }

    public class Route
    {
        public int OrderId { get; set; }
        public string From { get; set; }
        public string To { get; set; }
        public string Vehicle { get; set; }
    }
}
