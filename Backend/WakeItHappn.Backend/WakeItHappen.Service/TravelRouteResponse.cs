using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace WakeItHappen.Service
{
    public class TravelRouteResponse
    {
        public int TravelTimeMinutes { get; set; }
        public TravelDetails Details { get; set; }
        [JsonConverter(typeof(StringEnumConverter))]
        public TravelStatus TravelStatus { get; set; }
    }
}