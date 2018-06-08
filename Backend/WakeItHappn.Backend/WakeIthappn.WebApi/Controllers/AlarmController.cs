using System;
using Microsoft.AspNetCore.Mvc;
using WakeItHappen.Service;

namespace WakeIthappn.WebApi.Controllers
{
    [Route("api/[controller]")]
    public class AlarmController : Controller
    {
        // GET api/values
        [HttpGet]
        public JsonResult Get(AlarmData alarmData)
        {
            IAlarm alarmService;
            var alarmData2 = alarmData;
            
            if (alarmData2.AlarmId == Guid.Parse("aafea53a-3705-42ea-885a-e9bdf308ae31"))
            {
                alarmService = Mocks.For.AlarmSerice;
                alarmData2 = new AlarmData
                {
                    AlarmId = Guid.NewGuid(),
                    ArrivalTime = new DateTime(2018, 6, 8, 9, 30, 0),
                    FromLat = 51.525246,
                    FromLong = 0.084672,
                    ToLat = 51.559098,
                    ToLong = 0.074503
                };
            }
            else
            {
                alarmService = new AlarmService(new CityMapperClient());
            }

            var alarmRequest = alarmService.CreateAlarm(alarmData2);

            return new JsonResult(alarmRequest);
        }
    }
}