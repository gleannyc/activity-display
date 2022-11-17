SELECT
    userEmail,
    sentAt AS sent_at,
    EXTRACT(
        SECOND
        FROM
            sentAt
    ) AS SECOND,
    json_extract_scalar(
        properties,
        '$.fieldName'
    ) AS event
FROM
    `glean-analytics.user_analytics_prod.raw_events`
WHERE
    timestamp_trunc(
        sentAt,
        MINUTE
    ) = timestamp_trunc(
        timestamp_sub(
            TIMESTAMP(
                '2022-11-17 17:36:15',
                'America/New_York'
            ),
            INTERVAL 0 MINUTE
        ),
        MINUTE
    )
    AND json_extract_scalar(
        properties,
        '$.fieldName'
    ) = 'addExploreStep'
    AND NOT (
        userEmail IN (
            'andrew.lee@shortcut.com',
            'carlos.aguilar@shortcut.com',
            'carlosa@wingspan.app',
            'carlosl.glean@gmail.com',
            'cgaguilar@gmail.com',
            'cgaguilar+auth_test@gmail.com',
            'cgaguilar+newusertest@gmail.com',
            'cgaguilar+test.deleted@gmail.com',
            'cgaguilar+test@gmail.com',
            'cgaguilar+test3@gmail.com',
            'crysfitzgeraldmoore@gmail.com',
            'dan.s.eisenberg@gmail.com',
            'dan.s.eisenberg+test@gmail.com',
            'dan.s.eisenberg+test3@gmail.com',
            'dsecmu@gmail.com',
            'dsecmu+test@gmail.com',
            'hello@commas.space',
            'hello@vndrewlee.com',
            'joe.chadwick@shortcut.com',
            'nstokoe@gmail.com',
            'rohit.parulkar@gmail.com',
            'rohitp@wingspan.app',
            'rparulkar@collectors.com'
        )
        OR userEmail LIKE '%@glean.io'
        OR userEmail LIKE 'dan.s.eisenberg+%@gmail.com'
        OR userEmail LIKE 'dsecmu+%@gmail.com'
        OR userEmail LIKE 'cgaguilar+%@gmail.com'
    )
    AND projectId NOT IN (
        SELECT
            id
        FROM
            `glean-analytics.user_analytics_prod.customer_projects`
        WHERE
            is_internal_project = 1
    )
ORDER BY
    2 ASC
