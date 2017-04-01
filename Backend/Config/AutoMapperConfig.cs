using AutoMapper;
using CoreApi.Helpers.Authorization;
using CoreApi.Models;
using CoreApi.Models.ApiModels;

namespace CoreApi.Config
{
    public static class AutoMapperConfig
    {
        public static MapperConfiguration Config { get; set; } = new MapperConfiguration(opts =>
        {
            opts.CreateMap<FacebookProfileModel, User>().ForMember(x => x.Claims, cfg => cfg.Ignore())
                .ForMember(x => x.Logins, cfg => cfg.Ignore())
                .ForMember(x => x.Roles, cfg => cfg.Ignore())
                .ForMember(x => x.Id, cfg => cfg.Ignore())
                .ConstructUsing(profile => new User
                {
                    Name = profile.First_Name,
                    Surname = profile.Last_Name,
                    UserName = profile.Id,
                    Avatar = profile.Picture.Data.Url
                });

            opts.CreateMap<GoogleProfileModel, User>().ForMember(x => x.Claims, cfg => cfg.Ignore())
                .ForMember(x => x.Logins, cfg => cfg.Ignore())
                .ForMember(x => x.Roles, cfg => cfg.Ignore())
                .ForMember(x => x.Id, cfg => cfg.Ignore())
                .ConstructUsing(profile => new User
                {
                    Name = profile.Given_Name,
                    Surname = profile.Family_Name,
                    UserName = profile.Sub,
                    Avatar = profile.Picture
                });

            opts.CreateMap<Event, EventsApiModel>()
            .ConstructUsing(e => new EventsApiModel
            {
                Count = e.EventUsers.Count
            });

            opts.CreateMap<CreateEventApiModel, Event>();
            opts.CreateMap<RecycleItem, RecycleItemApiModel>()
                .ReverseMap();
            opts.CreateMap<Links, LinksApiModel>()
                .ReverseMap();
            opts.CreateMap<ItemPart, ItemPartApiModel>()
                .ReverseMap();

            opts.CreateMap<KidUser, KidUserApiModel>().ReverseMap();
            opts.CreateMap<Tree, TreeApiModel>();
            opts.CreateMap<KidUser, KidUserTreeApiModel>();
            opts.CreateMap<KidUser, KidUserNoTreeApiModel>()
                .ConstructUsing(kid => new KidUserNoTreeApiModel
                {
                    TreeCount = kid.Trees.Count
                });
            opts.CreateMap<TreeAddApiModel, Tree>();
            opts.CreateMap<User, UserApiModel>();
            opts.CreateMap<Cleaning, CleaningApiModel>();
        });
    }
}
