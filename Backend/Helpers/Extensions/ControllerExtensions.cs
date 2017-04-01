using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace CoreApi.Helpers.Extensions
{
    public static class ControllerExtensions
    {
        public static void TryCatchExecute<T>(this T controller, Action action)
        {
            try
            {
                action();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        public static async Task TryCatchExecute<T>(this T controller, Func<Task> action)
        {
            try
            {
                await action();
            } catch(Exception e)
            {
                Console.WriteLine(e);
            }
        }
    }
}
