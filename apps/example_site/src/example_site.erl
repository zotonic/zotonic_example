%% @doc A site is like a module, except that a site application
%% also contains a priv/zotonic_site.config file, from which
%% the system can see that this Erlang application is a Zotonic
%% site. All exports below are also valid for a Zotonic module.
%% @author Marc Worrell <marc@worrell.nl>
%% @copyright 2020-2022 Marc Worrell

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(example_site).
-author("Zotonic Team").

% Module attributes - shown in the /admin/modules interface.
-mod_title("Example Zotonic Site").
-mod_description("An Example Zotonic web site").

% The priority of the module. Higher is lower priority, default
% is 500. As a site module should overrule any defaults in
% Zotonic modules the priority is set to 10. Lower is reserved
% for special modules that might be added later.
-mod_prio(10).

% The datamodel version, as used by the z_module_manager to call
% the manage_schema function.
-mod_schema(1).

% Modules that should be started before this module
% In this case 'acl' as an edge to 'acl_user_group_managers' is
% added in the manage_schema/2 function.
% 'acl' is provided by the mod_acl_user_groups and other modules
% that implement access control.
% 'mod_oembed' is used to fetch embed code for a video in manage_schema.
% 'mod_video_embed' is used to fetch embed code for a video in manage_schema.
% 'mod_menu' is installs the main_menu, which is updated in manage_data.
-mod_depends([
    acl,
    mod_oembed,
    mod_video_embed,
    mod_menu
]).

% Exports - if exports change then the module is restarted after
% compilation.
-export([
    manage_schema/2,
    manage_data/2
    ]).

% This is the main header file, it contains useful definitions and
% also includes record defintions, as used by manage_schema/2.
-include_lib("zotonic_core/include/zotonic.hrl").


%%====================================================================
%% support functions go here
%%====================================================================

% The function manage_schema is called upon installation of the site or module.
% It is also called when the -mod_schema attribute at the top of this erlang
% module is incremented.
% If you make any change here then ensure that the schema version number is
% incremented.
% This function is called within a transaction, so it is safe to add any tables
% or other database modifications. Often calls to model initialization functions
% are added here.
% All #datamodel resources are added after the transaction, to prevent conflicts
% with other initialization code.
-spec manage_schema( z_module_manager:manage_schema(), z:context() ) -> ok | #datamodel{}.
manage_schema(_Version, _Context) ->
    #datamodel{

        % These are the extra categories for our website.
        % First is the unique name for the category, then the
        % "parent" category it belongs to, and then some properties
        % to be inserted.
        % Visually indented so that the hierarchy is clear.
        categories = [

            % {documentation, text, [
            %     {title, <<"Documentation">>}
            % ]}

        ],

        % These are resources installed by this module. They can use
        % the categories defined above.
        %
        % In the admin the resources are called 'pages', as that is a
        % concept that is easier to understand for editors.
        resources = [

            % This is the resource (page) for the home page.
            % The page_path is set to "/"" and there is a matching
            % dispatch rule in priv/dispatch/dispatch that matches
            % the "/" path to this resource.
            % The name "page_home" is a convention for the home page.
            % Names for generic pages (about, search etc) are encouraged
            % to start with "page_" to prevent name clashes with categories
            % and predicates (which don't have a prefix for their name).
            {page_home, collection, #{
                <<"title">> => <<"Home">>,
                <<"summary">> => <<"Short blurb for on the home page.">>,
                <<"body">> => <<
                    "<p>This is a story for on the home page.</p>"
                >>,
                <<"page_path">> => <<"/">>
            }},

            % This is an example article. Note that it is initialized using
            % a multilingual title. This is done using a "trans" record which
            % contains a list of language versions. The language code is the
            % two letter ISO 639-1 code.
            {page_article_1, article, #{
                <<"title">> => #trans{
                    tr = [
                        {en, <<"An article (nr 1)">>}
                    ]},
                <<"summary">> => <<"The summary for the article.">>,
                <<"body">> => <<
                    "<p>The body text of the article, can be very long.</p>"
                >>
            }},

            % Example video, using OEmbed. The module mod_oembed picks up the "oembed_url"
            % and will fetch proper embed code from (in this case) Youtube.
            % NOTA BENE: Check the 'media' data for a better way to import a medium item from an URL.
            {page_video_1, video, #{
                <<"title">> => <<"Zotonic: The Movie">>,
                <<"summary">> => <<"Example of a totally random video embedded via oembed.">>,
                <<"oembed_url">> => <<"https://www.youtube.com/watch?v=r9cmWJvXIj4">>
            }}
        ],

        % Resources with media files attached. The media files are provided in the
        % priv/schema_data folder. Note that 'media' are just resources like the one
        % above, only difference is that here we want to upload a file to be added to
        % the resource. All resources can have one file or embed code.
        media = [
            {page_image_1, "de-braak.jpg", #{
                <<"title">> => <<"De Braak">>,
                <<"address_city">> => <<"Amstelveen">>,
                <<"address_country">> => <<"nl">>,
                <<"summary">> => <<"Autumn view of park “De Braak” in Amstelveen.">>
            }},

            {page_video_2, "https://www.youtube.com/watch?v=Q9kgN9m_N2k", #{
                <<"title">> => <<"Making: Zotonic - The Movie">>,
                <<"body">> => <<
                    "<p>This is the \"Making of\" of Zotonic - the Movie.</p>",
                    "<p>Zotonic is the Erlang Web framework and content management system. ",
                    "More info on <a href=\"http://www.zotonic.com\">zotonic.com</a></p>"
                    >>
            }}
        ],

        % Predicates are the 'labels' on the edges (aka connections)
        % between pages. They give meaning to an edge.
        % Edges are added below.
        % Predicates themselves are just like resources, except that
        % they have an extra list to define the valid subject (from)
        % and object (to) categories.
        predicates = [

            % {predicate_name,
            %     [
            %         % Resource properties, just like with resources
            %         {title, {trans, [{en, <<"Predicate Title">>}]}}
            %     ],
            %     [
            %         % Valid from text resources, to text or media
            %         {text, text},
            %         {text, media}
            %     ]
            % }
        ],

        % Edges are tuples {subject, predicate, object}
        % The edges are directed from subject to object, with the
        % predicate as the label.
        % In the admin the edges are called 'connections', as that is a
        % concept that is easier to understand for editors.
        edges = [

            % {from_resource, predicate_name, to_resource}

            % The 'haspart' predicate is used to create collections of
            % resources. Usually the subject is a collection.
            {page_home, haspart, page_article_1},
            {page_home, haspart, page_video_1},

            % The predicate 'depiction' is used for images of articles,
            % people etc.
            {page_article_1, depiction, page_image_1}
        ]
    }.


%% This function runs after the schema is installed or updated.
-spec manage_data( z_module_manager:manage_schema(), z:context() ) -> ok.
manage_data(_Version, Context) ->
    % Ensure that the menu in the main_menu contains at least one page.
    % The main_menu is installed by mod_menu, but is initially empty.
    case m_rsc:p(main_menu, menu, Context) of
        None when None =:= undefined;
                  None =:= [] ->
            Menu = [
                #rsc_tree{
                    id = page_article_1,
                    tree = []
                }
            ],
            {ok, _} = m_rsc:update(main_menu, #{ <<"menu">> => Menu }, Context),
            ok;
        _ ->
            ok
    end.
