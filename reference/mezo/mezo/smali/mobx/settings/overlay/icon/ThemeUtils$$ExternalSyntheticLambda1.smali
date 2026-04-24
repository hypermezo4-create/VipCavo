# classes10.dex

.class public final synthetic Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/function/Predicate;


# static fields
.field public static final synthetic INSTANCE:Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda1;


# direct methods
.method static synthetic constructor <clinit>()V
    .registers 1

    new-instance v0, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda1;-><init>()V

    sput-object v0, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda1;->INSTANCE:Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda1;

    return-void
.end method

.method private synthetic constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .registers 2

    check-cast p1, Landroid/content/om/OverlayInfo;

    invoke-static {p1}, Lmobx/settings/overlay/icon/ThemeUtils;->lambda$setOverlayEnabled$1(Landroid/content/om/OverlayInfo;)Z

    move-result p1

    return p1
.end method
