import express from 'express';
const app = express();
import passport from 'passport';
import session from 'express-session';
import { OAuth2Strategy as GoogleStrategy } from 'passport-google-oauth';

passport.use(new GoogleStrategy({
            clientID: '349897640518-im76fe239qslprenkqa1tpmhlnt9ogcq.apps.googleusercontent.com',
            clientSecret: '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',
            callbackURL: 'http://localhost:3000/auth/google/callback',
        },
        function (accessToken, refreshToken, profile, cb) {
            return cb(null, profile);
        })
);

passport.serializeUser((user, done) => {
    console.log('displayName: ' + user.displayName);
    done(null, user);
});

passport.deserializeUser((user, done) => {
    done(null, user);
});

app.use(session({
    secret: 'secret',
    resave: false,
    saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());

app.get('/login', (req, res) => {
    res.sendFile('D:\\studing\\6_semestr\\programming_server_crossplatform_applications\\labs\\lab_18\\18-01.html');
});

app.get('/auth/google', passport.authenticate('google', { scope: ['profile', 'email'], prompt: 'select_account' }));

app.get(
    "/auth/google/callback",
    passport.authenticate("google", { failureRedirect: "/login" }),
    function (req, res) {
        res.redirect("/resource");
    }
);

app.get('/resource', (req, res, next) => {
    if (req.user) res.status(200).send('RESOURCE ' + req.user._raw);
    else res.redirect('/login');
});

app.get("/logout", (req, res) => {
    req.session.logout = true;
    req.logout(function (err) {
        if (err) {
            console.error(err);
        }
        res.redirect("/login");
    });
});

app.use(function (req, res) {
    res.status(404).send('ERROR 404: not found ' + req.url);
});

app.listen(3000, () => console.log('http://localhost:3000/login'));
