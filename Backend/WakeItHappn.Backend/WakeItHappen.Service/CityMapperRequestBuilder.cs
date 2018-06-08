namespace WakeItHappen.Service
{
    public class CityMapperRequestBuilder
    {
        public string Build(CityMapperRequest request)
        {
            return $"?startcoord={request.Start.ToString()}&endcoord={request.End.ToString()}&time={request.Time.ToString("s", System.Globalization.CultureInfo.InvariantCulture)}&time_type=arrival&key=9e05e361b20f93efcfeeebf642be8efe";
        }
    }
}