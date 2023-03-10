const movies =  [
    { 
        title: "Harry Potter",
        description: "Late one night, Albus Dumbledore and Minerva McGonagall, professors at Hogwarts School of Witchcraft and Wizardry, along with groundskeeper Rubeus Hagrid, deliver an orphaned infant wizard named Harry Potter to his Muggle aunt and uncle, Petunia and Vernon Dursley, his only living relatives.",
        cover: "/images/movie-covers/harry-potter.jpg"
    }, 
    { 
        title: "The Kardashians",
        description: "The Kardashians is an American reality television series which focuses on the personal lives of the Kardashian–Jenner family. The new show comes off the heels of their last show called Keeping Up with the Kardashians, which concluded in June 2021 after a 20-season run on E!.",
        cover: "/images/movie-covers/the-kardashians.jfif"
    }, 
    { 
        title: "Wednesday",
        description: "Wednesday Addams is expelled from her school after dumping live piranhas into the school's pool in retaliation for the boys' water polo team bullying her brother Pugsley. Consequently, her parents Gomez and Morticia Addams enroll her at their high school alma mater Nevermore Academy, a private school for monstrous outcasts, in the town of Jericho, Vermont. Wednesday's cold, emotionless personality and her defiant nature make it difficult for her to connect with her schoolmates and cause her to run afoul of the school's principal Larissa Weems. However, she discovers she has inherited her mother's psychic abilities which allow her to solve a local murder mystery.",
        cover: "/images/movie-covers/wednesday.png"
    }, 
    { 
        title: "Stranger Things",
        description: "Stranger Things is set in the fictional rural town of Hawkins, Indiana, during the 1980s. The nearby Hawkins National Laboratory ostensibly performs scientific research for the United States Department of Energy but secretly does experiments into the paranormal and supernatural, including those that involve human test subjects. Inadvertently, they have created a portal to an alternate dimension, 'the Upside Down'. The influence of the Upside Down starts to affect the unknowing residents of Hawkins in calamitous ways.",
        cover: "/images/movie-covers/stranger-things.jpg"
    }, 
    { 
        title: "Sex Education",
        description: "Sex Education primarily follows Otis Milburn, a student at Moordale Secondary School. Otis begins the series ambivalent about sex, in part because his single mother, Jean, is a sex therapist who frequently has affairs with male suitors but does not maintain romantic relationships.",
        cover: "/images/movie-covers/sex-education.jpg"
    },
    { 
        title: "Friends",
        description: "Rachel Green (Jennifer Aniston), a sheltered but friendly woman, flees her wedding day and wealthy yet unfulfilling life and finds childhood friend Monica Geller (Courteney Cox), a tightly wound but caring chef. Rachel becomes a waitress at West Village coffee house Central Perk after she moves into Monica's apartment above Central Perk and joins Monica's group of single friends in their mid-20s: previous roommate Phoebe Buffay (Lisa Kudrow), an odd masseuse and musician; neighbor Joey Tribbiani (Matt LeBlanc), a dim-witted yet loyal struggling actor and womanizer; Joey's roommate Chandler Bing (Matthew Perry), a sarcastic, self-deprecating data processor; and Monica's older brother and Chandler's college roommate Ross Geller (David Schwimmer), a sweet-natured but insecure paleontologist.",
        cover: "/images/movie-covers/friends.jpg"
    },
    { 
        title: "Marvel",
        description: "The Marvel Universe is strongly based on the real world. Earth in the Marvel Universe has all the features of the real one: same countries, same personalities (politicians, movie stars, etc.), same historical events (such as World War II), and so on; however, it also contains many other fictional elements: countries such as Wakanda and Latveria (very small nations) and organizations like the espionage agency S.H.I.E.L.D. and its enemies, HYDRA and A.I.M. In 2009 Marvel officially described its world's geography in a two-part miniseries, the Marvel Atlas.",
        cover: "/images/movie-covers/marvel.jpg"
    },
    { 
        title: "My Hero Acedemia",
        description: "The story of My Hero Academia is set in a world where currently most of the human population has gained the ability to develop superpowers called 'Quirks' (個性, Kosei), which occur in children within the age of four: it is estimated that around 80% of the world population has a Quirk. There are an endless number of Quirks, and it is extremely unlikely to find two people who have the exact same power, unless they are closely related. Among the Quirk-enhanced individuals, a few of them earn the title of Heroes, who cooperate with the authorities in rescue operations and apprehending criminals who abuse their powers, commonly known as Villains. In addition, Heroes who excel on their duties gain celebrity status and are recognized as 'Pro Heroes' (プロヒーロー, Puro Hīrō). Most heroes are popular based on their rankings, with higher ranking heroes receiving more popularity and public appeal, although it isn't uncommon for rookie heroes to gain such popularity as well.",
        cover: "/images/movie-covers/my-hero-acedemia.png"
    },
    { 
        title: "Formula 1: Drive to survive",
        description: "The 10-part series is the 'first to truly immerse the audience inside the cockpits, the paddock and the lives of the key players in Formula 1'. The series covers the 2018 Formula One World Championship and has 'unparalleled and exclusive access to the world's fastest drivers, team principals and owners, as well as Formula 1's own management team'.",
        cover: "/images/movie-covers/formula-1.jpg"
    },
];

var divListMovies = document.getElementsByClassName('list-movies');

for (var i = 0; i < divListMovies.length; i++) 
{
    const divMovie = document.createElement('div');
    divMovie.id = 'movies'; 
    divMovie.className = 'movies';

    movies.forEach(movie => {
        const a = document.createElement('a');
        a.href = 'serie.html';
        const div = document.createElement('div');
        div.className = 'movie movie-' + i;
        const img = document.createElement('img');
        img.src = movie.cover;
        img.className = 'img-fluid'
        div.appendChild(img);

        a.appendChild(div);
        divMovie.appendChild(a);
    })
    divListMovies[i].appendChild(divMovie);
}

function showRightMovie() {
    console.log('I got here!');
    //window.location.replace("serie.html");
    if (document.getElementById('title') !== null) 
    {
    document.getElementById('title').innerHTML = movies[3].title;

        var coverImage = document.getElementById('coverImage');
        const img = document.createElement('img');
        img.src = movies[3].cover;
        img.className = 'img-fluid'
        coverImage.appendChild(img);

        document.getElementById('description').innerHTML = movies[3].description;
    }
}
showRightMovie();