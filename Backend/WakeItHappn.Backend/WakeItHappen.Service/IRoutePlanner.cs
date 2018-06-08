using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using Newtonsoft.Json.Linq;

﻿namespace WakeItHappen.Service
{
    public interface IRoutePlanner
    {
        TravelRouteResponse GetTravelTime(TravelTimeRequest request);
    }

    public class TravelTime
    {
        public int travel_time_minutes { get; set; }
    }

   
}