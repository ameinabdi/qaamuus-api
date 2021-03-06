import { createRateLimiter } from '../apiRateLimiter';

export default (app) => {
  app.put(
    `/auth/password-reset`,
    require('./authPasswordReset').default,
  );
  app.put(
    `/auth/password-reset-phone`,
    require('./authPasswordResetPhone').default,
  );
  const emailRateLimiter = createRateLimiter({
    max: 6,
    windowMs: 15 * 60 * 1000,
    message: 'errors.429',
  });

  app.post(
    `/auth/send-email-address-verification-email`,
    emailRateLimiter,
    require('./authSendEmailAddressVerificationEmail')
      .default,
  );

  app.post(
    `/auth/send-phone-verification`,
    emailRateLimiter,
    require('./authSendSms')
      .default,
  );


  app.post(
    `/auth/send-password-reset-email`,
    emailRateLimiter,
    require('./authSendPasswordResetEmail').default,
  );

  app.post(
    `/auth/send-password-reset-phone`,
    emailRateLimiter,
    require('./authSendPasswordResetPhone').default,
  );

  const signInRateLimiter = createRateLimiter({
    max: 20,
    windowMs: 15 * 60 * 1000,
    message: 'errors.429',
  });

  app.post(
    `/auth/sign-in`,
    signInRateLimiter,
    require('./authSignIn').default,
  );

  app.post(
    `/auth/sign-in-phone`,
    signInRateLimiter,
    require('./authSignIn_phone').default,
  );
  const signUpRateLimiter = createRateLimiter({
    max: 20,
    windowMs: 60 * 60 * 1000,
    message: 'errors.429',
  });

  app.post(
    `/auth/sign-up`,
    signUpRateLimiter,
    require('./authSignUp').default,
  );

  app.post(
    `/auth/sign-up-phone`,
    signUpRateLimiter,
    require('./authSignUp_phone').default,
  );

  app.post(
    `/tenant/:tenantId/auth/sign-in`,
    signInRateLimiter,
    require('./authSignIn').default,
  );

  app.post(
    `/tenant/:tenantId/auth/sign-up`,
    signUpRateLimiter,
    require('./authSignUp').default,
  );

  app.put(
    `/auth/profile`,
    require('./authUpdateProfile').default,
  );

  app.put(
    `/auth/change-password`,
    require('./authPasswordChange').default,
  );

  app.put(
    `/auth/verify-email`,
    require('./authVerifyEmail').default,
  );

  app.put(
    `/auth/verify-phone`,
    require('./authVerifyPhone').default,
  );

  app.get(`/auth/me`, require('./authMe').default);

  app.get(
    `/auth/email-configured`,
    require('./authIsEmailConfigured').default,
  );
};
