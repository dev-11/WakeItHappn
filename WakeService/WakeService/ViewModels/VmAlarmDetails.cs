using System;
using System.Threading;

namespace WakeService.ViewModels
{
    public class VmAlarmDetails
    {
        public string WakeUpTimeAtOrigin { get; set; }
        public string ReadyTime { get; set; }
        public string ArrivalTimeAtDestination { get; set; }
        public string GpsCoordinatesOfOrigin { get; set; }
        public string GpsCoordinatesOfDestination { get; set; }
        
    }
}