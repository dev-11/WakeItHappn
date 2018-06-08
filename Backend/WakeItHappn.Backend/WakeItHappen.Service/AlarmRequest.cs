using System;

namespace WakeItHappen.Service
{
    public class AlarmRequest
    {
        public DateTime AlarmTime { get; set; }
        public Guid AlarmId { get; set; }
        public TravelRouteResponse TravelRoute { get; set; }
    }
}