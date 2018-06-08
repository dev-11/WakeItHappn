using System;

namespace WakeItHappen.Service
{
    public class AlarmService : IAlarm
    {
        
        private readonly IRoutePlanner _routePlanner;
        
        public AlarmService(IRoutePlanner routePlanner)
        {
            _routePlanner = routePlanner;
        }
        
        public AlarmRequest CreateAlarm(AlarmData alarmData)
        {
            var response = _routePlanner.GetTravelTime(new TravelTimeRequest
            {
                End = new Coordinate()
                {
                    Latitude = alarmData.ToLat, 
                    Longitude = alarmData.ToLong   
                },
                Start = new Coordinate()
                {
                    Latitude = alarmData.FromLat, 
                    Longitude = alarmData.FromLong   
                },
//                Start = alarmData.From,
                Time = alarmData.ArrivalTime
            });

            var retdata =  new AlarmRequest
            {
                AlarmId = Guid.NewGuid(),
                AlarmTime = alarmData.ArrivalTime.AddMinutes(-response.TravelTimeMinutes).AddMinutes(-alarmData.MinutesToGetReady)
            };

            return retdata;
        }
    }
}