<#-- @ftlvariable name="table" type="bbd.jportal2.Table" -->
<#import "basefunctions.ftl" as base>
// ########################################################################################################################
// ################## Generated Code. DO NOT CHANGE THIS CODE. Change it in the generator and regenerate ##################
// ########################################################################################################################
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using ${database.packageName}.EntityFrameworkCore.Models;

namespace ${database.packageName}.EntityFrameworkCore
{
    public partial class ${database.name}DbContextImpl : ${database.name}DbContext
    {
        public ${database.name}DbContextImpl([NotNull] DbContextOptions<${database.name}DbContextImpl> options) : base(options) { }

        <#list database.getTables() as table>
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        private static string ${table.name}${proc.name}Statement = @"
<#list base.formatEFLines(proc.lines) as pl>
${pl}
</#list>
";
        public override IQueryable<${table.name}Entity${proc.name}> ${table.name}Entity${proc.name}(${base.getTypedFields(proc.inputs)})
            => ${table.name}${proc.name}Set.FromSqlRaw(${table.name}${proc.name}Statement<#if proc.inputs?size gt 0>, </#if><#list proc.inputs as field>${field.name}<#compress><#sep>,</#compress></#list>);
        </#if>
        </#list>
        </#list>
    }
}