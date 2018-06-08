using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;

namespace WakeItHappen.Service
{
    public class CityMapperClient : IRoutePlanner
    {
        public TravelRouteResponse GetTravelTime(TravelTimeRequest request)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("https://developer.citymapper.com/api/1/traveltime/")
            };

            // Add an Accept header for JSON format.
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            string urlParameters = new CityMapperRequestBuilder().Build(new CityMapperRequest
            {
                Start = request.Start,
                End = request.End,
                Time = request.Time
            });
            
            HttpResponseMessage response = client.GetAsync(urlParameters).Result;  // Blocking call!
            if (response.IsSuccessStatusCode)
            {
                // Parse the response body. Blocking!

                var byteArrayMessage = response.Content.ReadAsByteArrayAsync();
                var stringMessage = Encoding.ASCII.GetString(byteArrayMessage.Result);
                
                var jsonMessage = Newtonsoft.Json.JsonConvert.DeserializeObject(stringMessage, typeof(TravelTime));
                
                return new TravelRouteResponse
                {
                    TravelTimeMinutes = (jsonMessage as TravelTime).travel_time_minutes,
                    TravelStatus = TravelStatus.Unknown,
                    Details = new TravelDetails()
                };

            }

            return new TravelRouteResponse();
        }
    }
}