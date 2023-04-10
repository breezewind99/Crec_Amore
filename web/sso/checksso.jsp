<%@ page import="com.nets.sso.agent.*" %>
<%
    //SSOConfig.
        try {
            AuthCheck auth = new AuthCheck(request, response);
            AuthStatus status = null;

            status = auth.checkLogon(AuthCheckLevel.Medium);
            if(status == AuthStatus.SSOFirstAccess) {
                out.println("SSO Status SSOFirstAccess");
                auth.trySSO();
                if(!CheckServer.isAlive())
                    status = AuthStatus.SSOUnAvaliable;
            } else if(status == AuthStatus.SSOFail) {
                out.println("SSO SSOFail");
            } else if(status == AuthStatus.SSOSuccess) {
                out.println("SSO SSOSuccess");
            } else if(status == AuthStatus.SSOUnAvaliable) {
                out.println("SSO SSOUnAvaliable status : " + auth.errorNumber());
            }
        } catch (Exception e) {
            out.println("SSO Excepition : " + e.getMessage());
        }
%>