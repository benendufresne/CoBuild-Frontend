import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/enums/job_enums.dart';

// Common Job components
class JobCommonComponents {
  static String jobPostTime(JobModel? model) {
    return "${S.current.posted} ${timeAgo(model?.created)}";
  }

  bool isValidForChat(String? status) {
    if ((status == StatusEnum.inprogress.enumValue.backendName) ||
        (status == StatusEnum.scheduled.enumValue.backendName)) {
      return true;
    }
    return false;
  }
}
