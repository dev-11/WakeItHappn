using System;

namespace WakeItHappen.Service
{
    public class AlarmData
    {
        public Guid AlarmId { get; set; }
        public DateTime ArrivalTime { get; set; }
        public Coordinate From { get; set; }
        public Coordinate To { get; set; }
    }
}