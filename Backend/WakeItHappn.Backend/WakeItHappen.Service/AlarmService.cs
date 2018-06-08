using System;

namespace WakeItHappen.Service
{
    public class AlarmService : IAlarm
    {
        private const int minutesToGetReady = 45;
        
        private readonly IRoutePlanner _routePlanner;
        
        public AlarmService(IRoutePlanner routePlanner)
        {
            _routePlanner = routePlanner;
        }
        
        public AlarmRequest CreateAlarm(AlarmData alarmData)
        {
            var response = _routePlanner.GetTravelTime(new TravelTimeRequest
            {
                End = alarmData.To,
                Start = alarmData.From,
                Time = alarmData.ArrivalTime
            });

            return new AlarmRequest
            {
                AlarmId = Guid.NewGuid(),
                AlarmTime = alarmData.ArrivalTime.AddMinutes(-response.TravelTimeMinutes-minutesToGetReady)
            };
        }
    }
}