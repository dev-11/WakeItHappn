﻿using System;
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
        public JsonResult Get()
        {
//            var service = Mocks.For.RoutPlanner.RoutePlanner;
//            var alarmService = Mocks.For.AlarmSerice;

            var alarmService = new AlarmService(new CityMapperClient());

//            var response = service.GetTravelTime(new TravelTimeRequest());
            var alarmRequest = alarmService.CreateAlarm(new AlarmData
            {
                AlarmId = Guid.NewGuid(),
                ArrivalTime = new DateTime(2018,6,8,9,30,0),
                From = new Coordinate
                {
                    Latitude = 51.525246,
                    Longitude = 0.084672,
                },
                To = new Coordinate
                {
                    Latitude = 51.559098,
                    Longitude = 0.074503
                }
            });
            
            
            return new JsonResult(alarmRequest);
        }
    }
}