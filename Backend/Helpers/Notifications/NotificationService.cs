using CoreApi.Config.Options;
using CoreApi.Helpers.Extensions;
using Flurl.Http;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Helpers.Notifications
{
    public class NotificationService
    {
        public const string FIREBASE_API = "https://fcm.googleapis.com/fcm/send";
        private FirebaseOptions opts { get; set; }

        public NotificationService(IOptions<ConfigOptions> opts)
        {
            this.opts = opts.Value.Firebase;
        }

        public async Task SendNotification(string deviceId, string body, string title, int priority = 10)
        {
            var flurl = new FlurlClient(FIREBASE_API);
            flurl.HttpClient.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", $"key={opts.ApiKey}");

            await this.TryCatchExecute(async () =>
            {
                var res = await flurl
                .PostJsonAsync(new
                {
                    to = deviceId,
                    priority = priority,
                    data = new
                    {
                        body = body,
                        title = title
                    }
                }).ReceiveString();

                Console.WriteLine(res);
            });
        }
    }
}
