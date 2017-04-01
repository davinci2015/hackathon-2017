using Microsoft.AspNetCore.SignalR;
using System.Linq;

namespace CoreApi.Websockets
{
    public class ChatHub : Hub
    {
        public string Send(string smt)
        {
            return string.Join(string.Empty, smt.Reverse());
        }

        public void Broadcast(string message)
        {
            Clients.All.serverMsg(message);
        }

        public void GameFinished(string name)
        {
            Clients.All.finish(true);
        }

        public void MemoryDone()
        {
            Clients.All.closeMemory(true);
        }

        public void TreePlanted(string lat, string lng)
        {
            Clients.All.treePlanted(new { lat, lng });
        }
    }
}
