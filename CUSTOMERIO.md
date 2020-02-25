### Segment
About Segment:
> Segment sends messages about activities in your mobile apps, websites or servers, receives those messages, and translates and forwards the message content to Destination tools

We are currently using 2 types of segment messages: `identify` and
`track`

To know more about the IDENTIFY api, [see](https://segment.com/docs/connections/spec/identify/)
> identify lets you tie a user to their actions and record traits about them


To know more about the TRACK api, [see](https://segment.com/docs/connections/spec/track/)
> The track API call is how you record any actions your users perform, along with any properties that describe the action.

This is where Event names get passed in order to track them.
- Events are identifiers to actions.
- Events names can be any string you want, but for bestpractices make it
human readable.
- Events are created "on the fly"

### Customerio
About Customerio:
> send targeted emails, push notifications, and SMS

Customerio centralizes user's data, and together with segment you can
see user's actions.

To inspect an user:
1. Log in into customer.io
2. Go to `audience`, then `people`
3. Search for user ID or email
4. Click on the said user
5. The `overview` tab shows the user's most recent activity, if you want
   to see specific activity
5. If you want to see specific activity, go to the `activity` tab
6. Identify the activity name and click to display information
