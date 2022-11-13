const functions = require("firebase-functions");

const algoliasearch = require('algoliasearch')

const client = algoliasearch(process.env.ALGOLIA_APPLICATION_ID, process.env.ALGOLIA_API_KEY)
const index = client.initIndex(process.env.ALGOLIA_INDEX)

function ensureValue(value, defaultValue) {
    if (value == null) {
        return defaultValue
    }
    return value
}

function toEvent(r) {
    return {
        id: r.id,
        createdDateTime: r.createdDateTime,
        creatorName: r.creatorName,
        creatorUserId: r.creatorUserId,
        description: r.description,
        endDateTime: r.endDateTime,
        eventDateTime: r.eventDateTime,
        imageUrl: r.imageUrl,
        location: r.location,
        public: r.public,
        title: r.title,
        volunteersNeeded: r.volunteersNeeded,
        durationMinutes: r.durationMinutes,
        karmaPoints: r.karmaPoints
    }
}

function createFacetFilter(locations) {
    locationsFilter = []

    for (i = 0; i < locations.length; i++) {
        locationsFilter.push("location:" + locations[i]);
    }

    return [
        locationsFilter,
        [
            "public:true"
        ]
    ];
}

function createNumericFilters(durations, volunteers) {
    let d = new Date()

    return [
        "durationMinutes>=" + durations.min,
        "durationMinutes<=" + durations.max,
        "volunteersNeeded>=" + volunteers.min,
        "volunteersNeeded<=" + volunteers.max,
        "eventDateTime>=" + d.getTime()
    ];
}

exports.search = functions.region("europe-west1").https.onCall((data, context) => {
    functions.logger.info("Handling search request");

    let {
        query,
        durationMinutesMin, 
        durationMinutesMax,
        volunteersMin,
        volunteersMax,
        locations
    } = data;

    query = ensureValue(query, "");
    durationMinutesMin = ensureValue(durationMinutesMin, 1);
    durationMinutesMax = ensureValue(durationMinutesMax, 3600);
    volunteersMin = ensureValue(volunteersMin, 1);
    volunteersMax = ensureValue(volunteersMax, 200);
    locations = ensureValue(locations, []);

    functions.logger.info(`Request Body: ${JSON.stringify(data)}`);
    functions.logger.info(`Query: ${query}`);

    const facetFilters = createFacetFilter(locations);

    functions.logger.info(facetFilters);

    const numericFilters = createNumericFilters(
        {min: durationMinutesMin, max:durationMinutesMax},
        {min: volunteersMin, max: volunteersMax}
    );


    functions.logger.info(numericFilters);
    const options = { facetFilters: facetFilters, numericFilters: numericFilters};
    return index
        .search(query, options)
        .then(result => {
            let {
                hits
            } = result

            events = [];

            for (let i = 0; i < hits.length; i++) {
                events.push(toEvent(hits[i]));
            }

            functions.logger.info(`Events:`);
            functions.logger.info(events);

            return events;
        })
})