import ApiResponseHandler from '../apiResponseHandler';
import AuthService from '../../services/auth/authService';

export default async (req, res, next) => {
  try {
    const payload = await AuthService.signupStudent(
      req.body.fullname,
      req.body.phoneNumber,
      req.body.gender,
      req.body.region,
      req.body.level,
      req.body.classlevel,
      req.body.password,
      req.body.invitationToken,
      req.body.tenantId,
      req,
    );

    await ApiResponseHandler.success(req, res, payload);
  } catch (error) {
    await ApiResponseHandler.error(req, res, error);
  }
};
