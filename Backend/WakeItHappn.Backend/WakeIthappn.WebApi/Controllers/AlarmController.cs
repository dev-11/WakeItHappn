using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Remotion.Linq.Clauses.ResultOperators;
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

            bool useRealData = true;
            
            // use this to change between mocked and live data
            if (useRealData)
            {
                alarmService = new AlarmService(new CityMapperClient());
  
            }
            else
            {
                alarmService = Mocks.For.AlarmSerice;
                alarmData = new AlarmData
                {
                    AlarmId = Guid.NewGuid(),
                    ArrivalTime = new DateTime(2018, 6, 8, 9, 30, 0),
                    FromLat = 51.525246,
                    FromLong = 0.084672,
                    ToLat = 51.559098,
                    ToLong = 0.074503
                };
            }


            var alarmRequest = alarmService.CreateAlarm(alarmData);

            return new JsonResult(alarmRequest);
        }
    }
}