using System;

namespace WakeItHappen.Service
{
    public class AlarmData
    {
        public Guid AlarmId { get; set; }
        public DateTime ArrivalTime { get; set; }
        public Double FromLat { get; set; }
        public Double FromLong { get; set; }
        public Double ToLat { get; set; }
        public Double ToLong { get; set; }
//        public Coordinate From { get; set; }
//        public Coordinate To { get; set; }
    }
}