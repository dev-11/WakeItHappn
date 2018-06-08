using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;

namespace WakeItHappen.Service
{
    public interface IRoutePlanner
    {
        TravelRouteResponse GetTravelTime(TravelTimeRequest request);
    }

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
                
                dynamic jsonMessage = Newtonsoft.Json.JsonConvert.DeserializeObject(stringMessage);
                
                string travel_time_minutes = jsonMessage.travel_time_minutes;


                return new TravelRouteResponse
                {
                    TravelTimeMinutes = int.Parse(travel_time_minutes),
                    TravelStatus = TravelStatus.Unknown,
                    Details = new TravelDetails()
                };

            }

            return new TravelRouteResponse();
        }
    }

    public class CityMapperRequestBuilder
    {
        public string Build(CityMapperRequest request)
        {
            return $"?startcoord={request.Start.ToString()}&endcoord={request.End.ToString()}&time={request.Time.ToString("s", System.Globalization.CultureInfo.InvariantCulture)}&time_type=arrival&key=9e05e361b20f93efcfeeebf642be8efe";
        }
    }

    public class CityMapperRequest
    {
        public Coordinate Start { get; set; }
        public Coordinate End { get; set; }
        public DateTime Time { get; set; }
    }
}