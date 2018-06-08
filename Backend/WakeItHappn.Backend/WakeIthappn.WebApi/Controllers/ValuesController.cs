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
    public class ValuesController : Controller
    {
        // GET api/values
        [HttpGet]
        public JsonResult Get()
        {
//            var service = Mocks.For.RoutPlanner.RoutePlanner;
            var alarmService = Mocks.For.AlarmSerice;

//            var response = service.GetTravelTime(new TravelTimeRequest());
            var alarmRequest = alarmService.CreateAlarm(new AlarmData
            {
                AlarmId = Guid.NewGuid(),
                ArrivalTime = new DateTime(),
                From = new Coordinate
                {
                    Latitude = 1,
                    Longitude = 2,
                },
                To = new Coordinate
                {
                    Latitude = 3,
                    Longitude = 4
                }
            });
            
            
            return new JsonResult(alarmRequest);
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}