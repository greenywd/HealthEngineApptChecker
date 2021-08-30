while true;
do if curl 'https://api.healthengine.com.au/graphql' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Firefox/91.0' -H 'content-type: application/json' --data-raw '{"operationName":"FilteredAppointmentsForPractice","variables":{"practiceId":"85027","display":"PLATFORM","from":"2021-08-30","numDays":2,"first":50,"specialty":"COVID-19 Vaccinations","typeFilter":{"patientType":"NEW","appointmentType":"Pfizer (First Dose)"},"test":false},"extensions":{},"query":"query FilteredAppointmentsForPractice($practiceId: ID!, $display: DisplayAppointment, $from: Date, $specialty: String!, $typeFilter: AppointmentTypeFilter, $first: Int, $numDays: Int, $after: String, $perDay: Int, $test: Boolean!) {\n  practice(id: $practiceId) {\n    id\n    appointments(search: {display: $display, specialty: [$specialty], date: {from: $from}, test: $test}, typeFilter: $typeFilter, after: $after, first: $first, perDay: $perDay, numDays: $numDays) {\n      appointments {\n        id\n        time\n        date\n        __typename\n      }\n      totalCount\n      pageInfo {\n        hasNextPage\n        startCursor\n        endCursor\n        __typename\n      }\n      __typename\n    }\n    __typename\n  }\n}\n"}' | jq --exit-status '.. |."date"? | select(. == "2021-08-24")' > /dev/null
then 
    afplay /System/Library/Sounds/Glass.aiff
    echo "Appointment found!"
else 
    echo "No Appointments"
fi
sleep 15
done