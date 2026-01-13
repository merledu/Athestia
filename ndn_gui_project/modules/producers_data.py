PRODUCER_SUBCATEGORIES = {
    "YouTube": [
        "/youtube/food/pasta",
        "/youtube/tech/ai",
        "/youtube/poem/cocomelon",
        "/youtube/films/bluewhale",
        "/youtube/vlogging/pakwheels"
    ],
    "Spotify": [
        "/spotify/pop/ed-sheeran",
        "/spotify/electro/cheap-thrills",
        "/spotify/dance/the-middle",
        "/spotify/disco/levitating",
        "/spotify/pop/be-kind"
    ],
    "Medium": [
        "/medium/technology/quantum-computing",
        "/medium/food/vegan-recipes",
        "/medium/travel/budget-tips",
        "/medium/health/mental-health",
        "/medium/business/startup-guide"
    ],
    "Kindle": [
        "/kindle/thriller/nightshade",
        "/kindle/horror/jaws-peter",
        "/kindle/horror/it-stephen",
        "/kindle/sci-fi/eve-anna",
        "/kindle/fantasy/wings--pike"
    ],
    "Steam": [
        "/steam/action/counter-strike",
        "/steam/adventure/life-is-strange",
        "/steam/horror/phasmophobia",
        "/steam/simulation/sims-4",
        "/steam/racing/forza-horizon"
    ],
    "Gmail": [
        "/gmail/personal/inbox",
        "/gmail/work/project-updates",
        "/gmail/notifications/social",
        "/gmail/promotions/deals",
        "/gmail/forums/discussions"
    ],
    "Reddit": [
        "/reddit/technology/programming",
        "/reddit/funny/memes",
        "/reddit/news/world-events",
        "/reddit/science/space",
        "/reddit/askreddit/curiosities"
    ],
    "Coursera": [
        "/coursera/compsci/machine-learning",
        "/coursera/healthcare/nutrition",
        "/coursera/business/finance",
        "/coursera/math/calculus",
        "/coursera/humanities/history"
    ],
    "Canva": [
        "/canva/design/logo-maker",
        "/canva/socialmedia/instagram-posts",
        "/canva/presentation/pitch-decks",
        "/canva/poster/event-promotion",
        "/canva/resume/creative-template"
    ],
    "Instagram": [
        "/instagram/travel/maldives-photos",
        "/instagram/food/desserts",
        "/instagram/fashion/streetwear",
        "/instagram/reels/funny-clips",
        "/instagram/stories/daily-life"
    ],
}

def get_producer_subcategories(producer_name):
    return PRODUCER_SUBCATEGORIES.get(producer_name, [])
