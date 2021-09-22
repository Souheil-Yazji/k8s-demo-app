local metadata(appName) =
{
    "name": appName,
    "namespace": "argocd",
    "finalizers": [
        "resources-finalizer.argocd.argoproj.io"
    ]
};

local spec(appName) =
{
    "destination": {
        "namespace": "argocd",
        "server": "https://kubernetes.default.svc"
    },
    "project": "default",
    "source": {
        "path": "argocd/apps/" + appName,
        "repoURL": "https://github.com/collinbrown95/k8s-demo-app.git",
        "targetRevision": std.extVar('targetBranch')
    },
    "syncPolicy": {
        "automated": {
        "prune": true,
        "selfHeal": true
    }
    }
};

local apps = [
    "app-1",
    "app-2",
    "app-3",
    "app-4"
];

{
    [app + ".yml"]: {
        metadata: metadata(app),
        spec: spec(app)
    } for app in apps
}